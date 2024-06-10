# Merge vs Rebase Workflow

[merging-vs-rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

## Merge

To merge the updated main into a feature branch:

```sh
git checkout main
git pull
git checkout feature
git merge main
```

## Rebase

To rebase a feature branch:

```sh
git checkout main
git pull
git checkout feature
git rebase main
```
