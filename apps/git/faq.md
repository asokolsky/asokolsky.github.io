# Git FAQs

Sources:

* [The Git Commands to Run Before Reading Any Code](https://piechowski.io/post/git-commands-before-reading-code/)

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

## What Changes the Most?

```sh
git log --format=format: --name-only --since="1 year ago" | \
    sort | uniq -c | sort -nr | head -20
```

## Who Built This?

```sh
git shortlog -sn --no-merges
```
If the top contributor from the overall shortlog doesn’t appear in a 6-month window

```sh
git shortlog -sn --no-merges --since="6 months ago"
```
flag that to the client immediately.

## Where Do Bugs Cluster?

```sh
git log -i -E --grep="fix|bug|broken" --name-only --format='' | \
    sort | uniq -c | sort -nr | head -20
```

## Is This Project Accelerating or Dying?

```sh
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
```

## How Often Is the Team Firefighting

```sh
git log --oneline --since="1 year ago" | \
    grep -iE 'revert|hotfix|emergency|rollback'
```
