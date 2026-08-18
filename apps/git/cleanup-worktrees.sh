#!/usr/bin/env bash
#
# Remove clean, merged Git worktrees beneath ~/Projects/.worktrees.
# The default mode is a read-only dry run.
# Pass --apply to
#   - remove worktrees and
#   - their local branches and
#   - exact sibling .review.md files, then
#   - remove unregistered candidate trees that contain only directories, and
#   - remove any top-level repo directory left completely empty.
# Remote branches are untouched.
#
# v0.0.1
#
# External dependencies:
#   - Always: bash, git, jq, awk, find, sort, and perl.
#   - GitLab origins: glab, authenticated for the repo.
#   - GitHub origins: gh, authenticated for the repo.

set -u
set -o pipefail

WORKTREE_ROOT="${WORKTREE_ROOT:-$HOME/Projects/.worktrees}"
COMMAND_TIMEOUT_SECONDS="${COMMAND_TIMEOUT_SECONDS:-30}"
APPLY=false

# Print command usage. Takes no arguments.
usage() {
    cat <<'EOF'
Usage: cleanup-worktrees.sh [--apply] [--root PATH] [--timeout SECONDS]

Without --apply, report worktrees that are safe to remove. With --apply,
remove only worktrees whose local state is clean and whose exact HEAD is proven
preserved by a normal or squash merge into the provider target branch.

The script never deletes remote branches. When a worktree is removed, its exact
sibling PATH.review.md file is also removed if present. Orphaned review files
are left untouched because their association can no longer be proven.

An unregistered candidate tree is removed only when every entry beneath it is a
directory. Files, symlinks, sockets, and other entries make the script leave the
tree untouched. Empty trees are removed bottom-up with rmdir, so concurrent new
content makes removal fail safely.

A top-level repo directory is removed once it is completely empty.

External dependencies:
  Always: bash, git, jq, awk, find, sort, and perl
  GitLab repos: authenticated glab
  GitHub repos: authenticated gh
EOF
}

# Print a status message.
# Arguments are joined with spaces.
log() {
    printf '%s\n' "$*"
}

# Report a skipped path.
# Arguments: path, reason.
skip() {
    printf 'SKIP  %s: %s\n' "$1" "$2" >&2
}

# Run a command with the configured timeout.
# Arguments: command and its arguments.
run_with_timeout() {
    /usr/bin/perl -e '
        $seconds = shift @ARGV;
        # The exec resets caught handlers; default SIGALRM termination exits 142.
        alarm $seconds;
        exec @ARGV;
    ' "$COMMAND_TIMEOUT_SECONDS" "$@"
}

# URL-encode one string for use in a provider API path or query.
# Argument: unencoded string. Prints the encoded value.
urlencode() {
    jq -nr --arg value "$1" '$value | @uri'
}

# Detect the provider and project path represented by an origin URL.
# Argument: Git remote URL. Prints a JSON object with provider and project.
remote_identity() {
    local remote_url="$1"
    local provider project_path

    case "$remote_url" in
        git@gitlab.com:*) provider=gitlab; project_path="${remote_url#git@gitlab.com:}" ;;
        ssh://git@gitlab.com/*) provider=gitlab; project_path="${remote_url#ssh://git@gitlab.com/}" ;;
        https://gitlab.com/*) provider=gitlab; project_path="${remote_url#https://gitlab.com/}" ;;
        http://gitlab.com/*) provider=gitlab; project_path="${remote_url#http://gitlab.com/}" ;;
        git@github.com:*) provider=github; project_path="${remote_url#git@github.com:}" ;;
        ssh://git@github.com/*) provider=github; project_path="${remote_url#ssh://git@github.com/}" ;;
        https://github.com/*) provider=github; project_path="${remote_url#https://github.com/}" ;;
        http://github.com/*) provider=github; project_path="${remote_url#http://github.com/}" ;;
        *) return 1 ;;
    esac

    jq -cn --arg provider "$provider" --arg project "${project_path%.git}" \
        '{provider: $provider, project: $project}'
}

# Look up a repo's default branch through its provider adapter.
# Arguments: provider name, namespace/project. Prints the branch name.
provider_default_branch() {
    local provider="$1"
    local project_path="$2"
    local encoded_project

    case "$provider" in
        gitlab)
            command -v glab >/dev/null 2>&1 || return 1
            encoded_project="$(urlencode "$project_path")" || return 1
            run_with_timeout glab api "projects/$encoded_project" 2>/dev/null |
                jq -er '.default_branch'
            ;;
        github)
            command -v gh >/dev/null 2>&1 || return 1
            run_with_timeout gh api "repos/$project_path" 2>/dev/null |
                jq -er '.default_branch'
            ;;
        *) return 1 ;;
    esac
}

# Resolve an exact merged change through the GitLab adapter.
# Arguments: namespace/project, exact source HEAD. Prints normalized JSON.
gitlab_merged_change() {
    local project_path="$1"
    local head="$2"
    local encoded_project mr_list mr_iid

    command -v glab >/dev/null 2>&1 || return 1
    encoded_project="$(urlencode "$project_path")" || return 1
    mr_list="$(run_with_timeout glab api \
        "projects/$encoded_project/repository/commits/$head/merge_requests" \
        2>/dev/null)" || return 1
    mr_iid="$(printf '%s' "$mr_list" | jq -er --arg head "$head" \
        '[.[] | select(.state == "merged" and .sha == $head)] | sort_by(.merged_at) | last | .iid')" || return 1
    run_with_timeout glab api "projects/$encoded_project/merge_requests/$mr_iid" 2>/dev/null |
        jq -ec '{kind: "MR", number: .iid, head: .sha,
            target_branch: .target_branch, merge_sha: .squash_commit_sha}'
}

# Resolve an exact merged change through the GitHub adapter.
# Arguments: owner/repo, exact source HEAD. Prints normalized JSON.
github_merged_change() {
    local project_path="$1"
    local head="$2"

    command -v gh >/dev/null 2>&1 || return 1
    run_with_timeout gh api "repos/$project_path/commits/$head/pulls" 2>/dev/null |
        jq -ec --arg head "$head" \
            '[.[] | select(.merged_at != null and .head.sha == $head)] |
            sort_by(.merged_at) | last |
            {kind: "PR", number: .number, head: .head.sha,
             target_branch: .base.ref, merge_sha: .merge_commit_sha}'
}

# Resolve a merged change through the selected provider adapter.
# Arguments: provider, namespace/project, exact source HEAD. Prints normalized JSON.
provider_merged_change() {
    local provider="$1"
    local project_path="$2"
    local head="$3"

    case "$provider" in
        gitlab) gitlab_merged_change "$project_path" "$head" ;;
        github) github_merged_change "$project_path" "$head" ;;
        *) return 1 ;;
    esac
}

# Compute one stable patch ID for a commit range.
# Arguments: worktree path, Git revision range. Prints the patch ID.
patch_id_for_range() {
    local worktree="$1"
    local range="$2"

    git -C "$worktree" diff --binary "$range" |
        git patch-id --stable |
        awk 'NR == 1 { value = $1 } END { if (NR == 1) print value; else exit 1 }'
}

# Prove that an exact worktree HEAD is preserved in a provider target branch.
# Arguments: worktree path, HEAD commit SHA. Prints the preservation method.
prove_preserved() {
    local worktree="$1"
    local head="$2"
    local remote_url identity provider project_path target_ref target_branch default_branch
    local change_json change_kind change_number change_head merge_sha base_sha
    local aggregate_patch squash_patch

    remote_url="$(git -C "$worktree" remote get-url origin 2>/dev/null)" || return 1
    identity="$(remote_identity "$remote_url")" || return 1
    provider="$(printf '%s' "$identity" | jq -er '.provider')" || return 1
    project_path="$(printf '%s' "$identity" | jq -er '.project')" || return 1
    default_branch="$(provider_default_branch "$provider" "$project_path")" || return 1
    target_branch="$default_branch"
    target_ref="refs/remotes/origin/$target_branch"

    run_with_timeout git -C "$worktree" fetch --quiet origin "$target_branch" || return 1

    if git -C "$worktree" merge-base --is-ancestor "$head" "$target_ref"; then
        printf 'normal merge into %s' "$target_branch"
        return 0
    fi

    change_json="$(provider_merged_change "$provider" "$project_path" "$head")" || return 1
    change_kind="$(printf '%s' "$change_json" | jq -er '.kind')" || return 1
    change_number="$(printf '%s' "$change_json" | jq -er '.number')" || return 1
    change_head="$(printf '%s' "$change_json" | jq -er '.head')" || return 1
    target_branch="$(printf '%s' "$change_json" | jq -er '.target_branch')" || return 1
    test "$change_head" = "$head" || return 1
    target_ref="refs/remotes/origin/$target_branch"
    if test "$target_branch" != "$default_branch"; then
        run_with_timeout git -C "$worktree" fetch --quiet origin "$target_branch" || return 1
    fi

    if git -C "$worktree" merge-base --is-ancestor "$head" "$target_ref"; then
        printf 'normal merge %s #%s into %s' "$change_kind" "$change_number" "$target_branch"
        return 0
    fi

    merge_sha="$(printf '%s' "$change_json" | jq -er '.merge_sha')" || return 1
    base_sha="$(git -C "$worktree" merge-base "$head" "$target_ref")" || return 1
    git -C "$worktree" merge-base --is-ancestor "$merge_sha" "$target_ref" || return 1

    aggregate_patch="$(patch_id_for_range "$worktree" "$base_sha..$head")" || return 1
    squash_patch="$(patch_id_for_range "$worktree" "$merge_sha^..$merge_sha")" || return 1
    test "$aggregate_patch" = "$squash_patch" || return 1

    printf 'squash merge %s #%s into %s' "$change_kind" "$change_number" "$target_branch"
}

# Audit and optionally remove one registered worktree and its associated files.
# Argument: absolute candidate worktree path. Uses APPLY to select dry-run/apply.
cleanup_candidate() {
    local worktree="$1"
    local actual_root branch branch_label head primary_root dirty submodule_dirty
    local preservation submodule_state initialized_submodules review_file review_label
    local cleanup_incomplete=false

    actual_root="$(git -C "$worktree" rev-parse --show-toplevel 2>/dev/null)" || {
        cleanup_empty_orphan_tree "$worktree"
        return
    }
    test "$actual_root" = "$worktree" || {
        skip "$worktree" 'candidate is not the worktree root'
        return
    }

    branch="$(git -C "$worktree" branch --show-current)"
    branch_label="${branch:-detached HEAD}"
    head="$(git -C "$worktree" rev-parse HEAD)" || {
        skip "$worktree" 'cannot resolve HEAD'
        return
    }
    primary_root="$(git -C "$worktree" worktree list --porcelain | awk \
        '$1 == "worktree" { print substr($0, 10); exit }')"
    test -n "$primary_root" || {
        skip "$worktree" 'cannot resolve primary worktree'
        return
    }

    review_file="${worktree}.review.md"
    review_label='no review file'
    if test -e "$review_file" || test -L "$review_file"; then
        if ! test -f "$review_file" && ! test -L "$review_file"; then
            skip "$worktree" "review path is not a file or symlink: $review_file"
            return
        fi
        review_label="review file: $review_file"
    fi

    dirty="$(git -C "$worktree" status \
        --porcelain=v1 --untracked-files=all --ignore-submodules=none)" || {
        skip "$worktree" 'superproject status failed'
        return
    }
    test -z "$dirty" || {
        skip "$worktree" 'superproject is dirty'
        return
    }

    submodule_dirty="$(git -C "$worktree" submodule foreach --quiet --recursive '
        dirty="$(git status --porcelain=v1 --untracked-files=all --ignore-submodules=none)" || exit $?
        if test -n "$dirty"; then
            printf "Dirty submodule: %s\n%s\n" "$displaypath" "$dirty" >&2
            exit 1
        fi
    ' 2>&1)" || {
        skip "$worktree" "submodule audit failed: $submodule_dirty"
        return
    }

    submodule_state="$(git -C "$worktree" submodule status --recursive 2>/dev/null)" || {
        skip "$worktree" 'cannot inspect submodule initialization state'
        return
    }
    initialized_submodules="$(printf '%s\n' "$submodule_state" |
        awk 'NF && substr($0, 1, 1) != "-" { count++ } END { print count + 0 }')"

    preservation="$(prove_preserved "$worktree" "$head")" || {
        skip "$worktree" 'HEAD is not provably preserved by a normal or squash merge'
        return
    }

    printf 'SAFE  %s [%s @ %.12s; %s; initialized submodules: %s; %s]\n' \
        "$worktree" "$branch_label" "$head" "$preservation" \
        "$initialized_submodules" "$review_label"
    if ! $APPLY; then
        return
    fi

    git -C "$primary_root" worktree remove --force "$worktree" || {
        skip "$worktree" 'git worktree remove failed'
        return
    }
    if test -n "$branch"; then
        git -C "$primary_root" branch -D "$branch" >/dev/null || {
            skip "$worktree" "worktree removed, but local branch $branch remains"
            cleanup_incomplete=true
        }
    fi
    if test -e "$review_file" || test -L "$review_file"; then
        rm -- "$review_file" || {
            skip "$review_file" 'worktree removed, but review file removal failed'
            cleanup_incomplete=true
        }
    fi
    git -C "$primary_root" worktree prune || {
        skip "$primary_root" 'worktree removed, but prune failed'
        cleanup_incomplete=true
    }
    if $cleanup_incomplete; then
        printf 'PARTIAL %s [worktree removed; see preceding cleanup failures]\n' "$worktree"
        return
    fi
    if test -n "$branch"; then
        printf 'DONE  %s [deleted local branch %s; removed review file if present; remote branch untouched]\n' \
            "$worktree" "$branch"
    else
        printf 'DONE  %s [detached worktree removed; removed review file if present; remote branches untouched]\n' \
            "$worktree"
    fi
}

# Report and optionally remove one unregistered tree containing only directories.
# Argument: absolute candidate path. Uses APPLY to select dry-run/apply.
# The initial find rejects every non-directory entry, including symlinks. The
# bottom-up rmdir pass then refuses removal if content appears concurrently.
cleanup_empty_orphan_tree() {
    local orphan="$1"
    local unexpected

    unexpected="$(find "$orphan" -mindepth 1 ! -type d -print -quit 2>/dev/null)" || {
        skip "$orphan" 'cannot inspect unregistered candidate tree'
        return
    }
    test -z "$unexpected" || {
        skip "$orphan" "not a registered Git worktree; contains non-directory entry: $unexpected"
        return
    }

    printf 'ORPHAN %s [unregistered tree contains only directories]\n' "$orphan"
    if ! $APPLY; then
        return
    fi

    find "$orphan" -depth -type d -exec rmdir -- {} \; 2>/dev/null
    if test -e "$orphan" || test -L "$orphan"; then
        skip "$orphan" 'empty orphan removal incomplete; content may have appeared concurrently'
        return
    fi
    printf 'DONE  %s [removed empty unregistered directory tree]\n' "$orphan"
}

# Report and optionally remove one empty top-level repo directory.
# Argument: absolute repo directory path. Uses APPLY to select dry-run/apply.
# Removal uses rmdir, which refuses any directory that still holds an entry, so
# this can never discard a worktree, a review file, or a nested directory tree.
cleanup_empty_repo_dir() {
    local repo_dir="$1"

    test -z "$(ls -A -- "$repo_dir" 2>/dev/null)" || return

    printf 'EMPTY %s [no worktrees or review files remain]\n' "$repo_dir"
    if ! $APPLY; then
        return
    fi

    rmdir -- "$repo_dir" || {
        skip "$repo_dir" 'empty repo directory removal failed'
        return
    }
    printf 'DONE  %s [removed empty repo directory]\n' "$repo_dir"
}

# Parse arguments, validate dependencies, and process worktrees.
# Arguments: command-line options accepted by usage().
main() {
while test "$#" -gt 0; do
    case "$1" in
        --apply) APPLY=true ;;
        --root)
            shift
            test "$#" -gt 0 || { usage >&2; exit 2; }
            WORKTREE_ROOT="$1"
            ;;
        --timeout)
            shift
            test "$#" -gt 0 || { usage >&2; exit 2; }
            COMMAND_TIMEOUT_SECONDS="$1"
            ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'Unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
    shift
done

case "$COMMAND_TIMEOUT_SECONDS" in
    ''|*[!0-9]*) printf 'Timeout must be a positive integer.\n' >&2; exit 2 ;;
esac
test "$COMMAND_TIMEOUT_SECONDS" -gt 0 || {
    printf 'Timeout must be greater than zero.\n' >&2
    exit 2
}

for dependency in git jq awk find sort /usr/bin/perl; do
    command -v "$dependency" >/dev/null 2>&1 || {
        printf 'Missing dependency: %s\n' "$dependency" >&2
        exit 2
    }
done

test -d "$WORKTREE_ROOT" || {
    printf 'Worktree root does not exist: %s\n' "$WORKTREE_ROOT" >&2
    exit 2
}
WORKTREE_ROOT="$(cd "$WORKTREE_ROOT" && pwd -P)"

if $APPLY; then
    log "Applying cleanup beneath $WORKTREE_ROOT"
else
    log "Dry run beneath $WORKTREE_ROOT (pass --apply to remove safe worktrees)"
fi

found=false
while IFS= read -r -d '' candidate; do
    found=true
    cleanup_candidate "$candidate"
done < <(find "$WORKTREE_ROOT" -mindepth 2 -maxdepth 2 -type d -print0 | sort -z)

# Runs after the candidate pass so a directory emptied by this run is collected
# in the same run.
while IFS= read -r -d '' repo_dir; do
    cleanup_empty_repo_dir "$repo_dir"
done < <(find "$WORKTREE_ROOT" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

if ! $found; then
    log 'No worktree candidates found.'
fi
}

if test "${BASH_SOURCE[0]}" = "$0"; then
    main "$@"
fi
