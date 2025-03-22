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
