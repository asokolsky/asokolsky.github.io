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

## Delete the local repo's branches

Delete the local branches which are merged:
```sh
git branch --merged | grep -v \* | xargs git branch -D
```

Get all the repo's branches except for branch `master` and delete these:
```sh
git branch | grep -v master | xargs git branch -D
```

## git whoami

with github:
```sh
gh api user | jq -r '"\(.name) \(.login)"'
```
