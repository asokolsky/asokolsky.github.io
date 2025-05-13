# Git FAQs

## Undo the last local commit

```sh
git reset HEAD~
```

## Undo Uncommitted or Unsaved Changes

Unstage all the files you might have staged `with git add`:
```sh
git reset
```
Revert all the local uncommitted changes.  Execute in the repo root:
```sh
git checkout .
```

## Delete the repo's branches

Get all the repo's branches except for branch `master` and delete these:
```sh
git branch | grep -v master | xargs git branch -D
```
