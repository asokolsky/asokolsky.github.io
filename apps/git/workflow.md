# Merge vs Rebase Workflow

This is part of the [development cycle](/software-engineering/development-cycle.html).

[merging-vs-rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

Presumably, you did:

* start with the latest version of the trunk:
```sh
git checkout main
git pull
```
* proceed with creating a feature branch:
```sh
git checkout -b feature
```

THEN the trunk (`main` or `master`) was updated.

## Merge

To merge the updated `main` into a feature branch:

```sh
git checkout main
git pull
git checkout feature
git merge main
```
If conflicts arise, resolve them and continue the merge.

## Rebase

To rebase a feature branch on the updated `main`:

```sh
git checkout main
git pull
git checkout feature
git rebase main
```
If conflicts arise, resolve them and continue the rebase.

## Publish it

```sh
git push --force origin feature
```