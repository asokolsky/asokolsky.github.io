# Git Worktree Workflow

Git worktrees let one repository have multiple checked-out branches in separate directories. DLI developers use them to isolate concurrent issues, merge requests, reviews, and urgent fixes without repeatedly switching or stashing the main worktree.

## Terminology

This document uses Git's worktree terminology:

- Repository — the shared Git object database and administrative data used by all worktrees.
- Worktree — a checked-out working directory plus its associated Git state.
- Main worktree — the first worktree created by `git clone` or `git init`. Git documentation calls this the main worktree even when the repository's default branch has another name.
- Linked worktree — an additional worktree created with `git worktree add` and linked to the same repository.
- Projects root — the local parent directory that contains main worktrees and the sibling `.worktrees` directory. This is a convention in this document, not Git terminology.
- Default branch — the repository's primary integration branch, commonly `main` or `master`. It is distinct from the term main worktree.

## Benefits

- Stable Main Worktree. Keep the main worktree on the default branch and free of task changes. It remains a reliable place to fetch remote state, inspect repository-wide status, and manage linked worktrees.
- Safer Concurrent Work. Each task gets its own directory, branch, dependency state, and untracked files. Formatting, staging, tests, or cleanup in one task are less likely to affect another.
- Faster Context Switching. Move between tasks by changing directories instead of stashing partial work or repeatedly switching branches. Long-running builds and local services can remain associated with their linked worktree.
- Exact Merge/Pull Request Reviews. A detached linked worktree can inspect the exact merge request head without moving the main worktree or confusing local changes with the submitted diff.
- Explicit Cleanup. Task directories make completed and abandoned work visible. A standard cleanup check prevents clean but unmerged commits, untracked files, or submodule changes from being deleted accidentally.

## When To Use A Worktree

Use a linked worktree for:

- Issue- or merge-request-driven implementation
- Concurrent development tasks in the same repository
- Urgent fixes while another task is incomplete
- Exact-head merge request review
- Work that runs task-specific builds, services, or dependency installation

A linked worktree is optional for a brief read-only inspection when the main worktree is clean and no branch change is needed.

## Directory Layout

Keep main and linked worktrees separate beneath a common projects root:

```text
{projects-root}/{repo}
{projects-root}/.worktrees/{repo}/{work-id}-{short-slug}
```

Use the projects root appropriate to the workstation:

| Operating System | Example Projects Root |
|---|---|
| macOS | `/Users/{user}/Projects` |
| Linux | `/home/{user}/Projects` |

You can choose another absolute projects root, just use the same root consistently for main worktrees and `.worktrees`.

For example, a developer working in `my-repo` could have this directory tree:

```text
{projects-root}/
├── my-repo/                         # Main worktree on main
└── .worktrees/
    └── my-repo/
        ├── issue-123-foo-bar/         # Issue implementation
        └── fix-connection-timeout/    # Independent urgent fix
```

Do not create a linked worktree inside the main worktree.

## Naming

Use lowercase kebab-case and short descriptive slugs.

| Work Type | Directory Pattern | Example |
|---|---|---|
| Merge request | `mr-{iid}-{slug}` | `mr-161-china-migration-runbook` |
| Issue | `issue-{iid}-{slug}` | `issue-883-immutable-delivery` |
| Feature | `feat-{slug}` | `feat-authenticated-smoke` |
| Fix | `fix-{slug}` | `fix-capacity-reservation-races` |
| Documentation | `docs-{slug}` | `docs-deployment-runbook` |
| Experiment | `experiment-{slug}` | `experiment-cache-policy` |

Repository branch naming rules still apply. The branch and worktree directory do not need identical names.

## Create Or Reuse A Worktree

Inspect existing worktrees before creating one:

```bash
git worktree list
```

Reuse an existing worktree for the same task. Otherwise, refresh the default branch and create an isolated task branch:

```bash
git fetch origin main

git worktree add \
  -b {branch-name} \
  {projects-root}/.worktrees/{repo}/{work-id}-{slug} \
  origin/main
```

Follow repository-specific instructions when the default branch is not `main` or the task has a prescribed base branch.

## Review A Merge Request At Its Exact Head

Fetch the merge request head and create a detached worktree:

```bash
git fetch origin \
  +refs/merge-requests/{iid}/head:refs/remotes/origin/mr-{iid}

git worktree add \
  --detach \
  {projects-root}/.worktrees/{repo}/mr-{iid}-{slug} \
  refs/remotes/origin/mr-{iid}
```

Verify that the checked-out commit matches the merge request's current head before drawing conclusions.

## Work Within The Linked Worktree

- Make task changes only in the corresponding linked worktree.
- Keep the main worktree on the default branch and free of task changes.
- Check `git status --short` and `git diff` before staging.
- Preserve unrelated or pre-existing changes.
- Run formatting, tests, builds, and local services from the linked worktree.
- Inspect `git diff --cached` before committing.
- Follow the repository's commit and merge request procedures.

## Decide Whether Cleanup Is Safe

Do not remove a worktree until:

1. Its exact path and associated branch are known.
2. Its superproject and initialized submodules contain no modified, staged, or untracked files.
3. Its commits are merged, squash-merged, preserved remotely, or explicitly approved for discard.
4. Associated merge request, pipeline, deployment, or review work has reached the required outcome.

A clean status alone does not make cleanup safe. A clean branch can still contain commits that exist nowhere else.

Squash merges need special care because the original branch commits are not ancestors of the squash commit. Confirm the live merge request head and recorded squash commit rather than relying on a single `git cherry` result.

### Verify A Normal Merge

Refresh the target and test ancestry:

```bash
git fetch origin main
git merge-base --is-ancestor {branch-commit} origin/main
```

Exit status `0` confirms that the commit is an ancestor of `origin/main`. A nonzero result requires further investigation.

### Verify A Squash Merge

Verify all of the following:

1. The live merge request state is `merged`.
2. GitLab reports the expected source `sha` and a non-null `squash_commit_sha`.
3. The local branch tip equals the recorded merge request head SHA. Preserve or review any later local commits separately.
4. The squash commit is reachable from the refreshed target:

   ```bash
   git fetch origin main
   git merge-base --is-ancestor {squash-commit-sha} origin/main
   ```

5. The aggregate merge request change matches the squash commit change:

   ```bash
   git diff --binary {mr-base-sha}..{mr-head-sha} |
     git patch-id --stable

   git diff --binary {squash-commit-sha}^..{squash-commit-sha} |
     git patch-id --stable
   ```

Matching aggregate patch IDs provide strong evidence that the squash commit preserves the merge request change. When IDs differ because of conflict resolution or target-branch adjustments, inspect both aggregate patches and account for every difference before deletion.

`git cherry origin/main {branch-name}` is supplementary evidence only:

- `-` covers only that individual commit.
- `+` identifies an individual commit without a detected upstream equivalent.
- Any `+` requires investigation.
- A mixture of `-` and `+` does not establish that the whole branch is merged.
- A genuine squash merge can show `+` for every component commit because none individually matches the combined squash patch.

## Remove A Completed Worktree

Remove the worktree through Git, then delete its local branch and prune metadata:

```bash
git worktree remove /absolute/worktree/path
git branch -d {branch-name}
git worktree prune
git worktree list
```

Use `git branch -D` only after independently verifying that squash-merged or otherwise non-ancestor work is preserved, or after explicit approval to discard it.

Do not substitute recursive filesystem deletion for `git worktree remove`.

## Protect Submodule Work

Before forced submodule deinitialization or worktree removal, inspect the superproject without honoring submodule ignore configuration:

```bash
git -C /absolute/worktree/path status \
  --porcelain=v1 \
  --untracked-files=all \
  --ignore-submodules=none
```

Then inspect every initialized submodule recursively from inside that submodule:

```bash
git -C /absolute/worktree/path submodule foreach --recursive '
  dirty="$(git status \
    --porcelain=v1 \
    --untracked-files=all \
    --ignore-submodules=none)" || exit $?
  if test -n "$dirty"; then
    printf "Dirty submodule: %s\n%s\n" "$displaypath" "$dirty" >&2
    exit 1
  fi
'
```

Stop if either check produces dirty-state output or exits unsuccessfully. Ordinary superproject status may hide submodule changes through `.gitmodules`, local Git configuration, or command-line ignore settings.

If normal removal reports that the worktree contains submodules, deinitialize them only after both audits pass:

```bash
git -C /absolute/worktree/path submodule deinit -f --all
git worktree remove /absolute/worktree/path
```

If the current Git version still refuses removal solely because submodule metadata exists, forced removal is permitted only after the recursive clean-state and branch-preservation checks:

```bash
git worktree remove --force /absolute/worktree/path
```

## Keep Remote Cleanup Separate

Removing a local worktree and branch does not authorize deletion of its remote branch. Delete remote branches only when the merge request workflow or repository owner calls for it.

Use one shell invocation to resolve the exact ref, delete it, and verify that same ref. This preserves the variable and the status returned directly by `git ls-remote`:

```bash
remote_ref="refs/heads/{branch-name}"
remote_output="$(git ls-remote --exit-code --heads origin "$remote_ref")"
result=$?
test "$result" -eq 0 || exit "$result"

IFS=$'\t' read -r remote_oid resolved_ref extra <<< "$remote_output"
test -n "$remote_oid" || exit 1
test "$resolved_ref" = "$remote_ref" || exit 1
test -z "$extra" || exit 1

git push \
  --force-with-lease="$remote_ref:$remote_oid" \
  origin \
  ":$remote_ref"

if git ls-remote --exit-code --heads origin "$remote_ref"; then
  echo "Remote branch still exists: $remote_ref" >&2
  exit 1
else
  result=$?
  test "$result" -eq 2 || exit "$result"
fi
```

The initial lookup must resolve exactly the intended ref. The explicit lease makes deletion fail if the remote ref no longer points to the captured object ID. In the final lookup, exit status `2` confirms that the previously resolved ref is absent; any other nonzero status is a lookup failure, not deletion evidence.

## Troubleshooting

### The Worktree Already Exists

Use `git worktree list` to find and reuse the existing linked worktree. Do not create a duplicate directory or parallel branch for the same task.

### Git Reports That The Branch Is Already Checked Out

Each branch can be checked out in only one worktree. Use the path reported by `git worktree list`, or choose the correct different branch for the new task.

### Git Refuses To Remove A Worktree With Submodules

First verify the superproject and all initialized submodules recursively. After confirming that the worktree is clean and its branch is preserved, deinitialize its submodules and retry worktree removal. Some Git versions require forced worktree removal after this deinitialization.

### Git Refuses To Delete A Squash-Merged Branch

This is expected when the original commits are not ancestors of the squash commit. Verify the live merged merge request, its exact head, the recorded squash commit, and the aggregate change before force-deleting the local branch.
