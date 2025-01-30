# git squash

## Squash Commits Locally

Check the git log to identify the commit you want to go back to:
```
> git log --oneline  -n 10
72be799 (HEAD -> main, origin/main, origin/HEAD) Merge branch 'main' of github.com:asokolsky/asokolsky.github.io
98e92a7 colima update
286ac90 wip
12cb642 Merge branch 'main' of https://github.com/asokolsky/asokolsky.github.io
93375fb wip
031ba39 Merge branch 'main' of github.com:asokolsky/asokolsky.github.io
31d1349 wip
5888ab0 ham update
214ae0f git updates
```

I want to squash commits before 5888ab0.  Reset head to 5888ab0:
```sh
git reset --soft 5888ab0
```

alternatively:
```
git reset --soft HEAD~6
```

This results in the files modified in the last commits being staged:
```
> git status
On branch main
Your branch is behind 'origin/main' by 7 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   apps/docker/colima.md
        new file:   apps/git/config.md
        modified:   apps/git/index.md
        modified:   apps/remote-access-rdp.md
        modified:   apps/remote-access-vnc.md
        modified:   ham/index.md
        modified:   macos/cli.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        apps/git/squash.md
```

Squash the changes into a single commit:
```
> git commit -m "testing squash"
[main 9a33bf1] testing squash
 7 files changed, 145 insertions(+), 106 deletions(-)
 create mode 100644 apps/git/config.md
```

## Push the Squashed Commit

Naive attempt fails:
```
> git push
To github.com:asokolsky/asokolsky.github.io.git
 ! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs to 'github.com:asokolsky/asokolsky.github.io.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Force the push
```sh
git push --force-with-lease origin main
```
