# Development Cycle

Everyday life of a software engineer looks like this.

## 0. Issue

Problem statement comes as a bug database issue.  This could be any one of:

* github/gitlab repo issue
* Jira issue

Make sure you have:

* a plan.  Or design.  Write it down.  I favor "how this works" document in markdown, somewhere close to sources - ideally in the same repo.  Use [Mermaid diagrams](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams).
* a test.  Know you way around unit tests.  Automate it.

Lets assume you are working on:

* project `foobar`
* issue `#123`
* repo's trunk is called `main`

## 1. Create a new branch

I use [git](/apps/git).

Development is done on [a dedicated branch](https://www.atlassian.com/git/tutorials/using-branches). I prefer to name my development branch after the issue to ensure [traceability](https://docs.google.com/presentation/d/11PZ2vYSt0FWO--JqKaLNq41EPGts-Fke4JTMk5DfX-w/edit?usp=sharing).  In this case I would call it `foobar-123`.  Alternative [branch naming conventions](https://graphite.dev/guides/git-branch-naming-conventions) do work.

[Checkout](https://git-scm.com/docs/git-checkout) the repo's trunk
```sh
git checkout main
```

[pull in](https://git-scm.com/docs/git-pull) the latest version of the repo:
```sh
git pull
```

Create the branch:
```sh
git checkout -b foobar-123
```

Your IDE can offer you GUI for accomplishing the above but the CLI always works.


## 2. Develop on the branch

Develop your code.  This will result in:

* modifying the existing code/documentation;
* adding new code/documentation;
* executing tests and verifying that the results meet your expectations as stated in the issue.

## 3. Commit your changes to the branch and publish the branch

0. Identify the list of changes you made during the development using [git status](https://git-scm.com/docs/git-status) or the IDE facilities;

1. Use [git add](https://git-scm.com/docs/git-add) to stage the changes:

```sh
git add foo.c
```

2. Commit your changes to the branch using [git commit](https://git-scm.com/docs/git-commit).  The message should follow [this convention](https://www.conventionalcommits.org/en/v1.0.0/#summary).

```sh
git commit -m 'fix: foo.c to tolerate invalid input'
```

3. Publish the branch to the remote repo using [git push](https://git-scm.com/docs/git-push):

```sh
git push -u origin foobar-123
```

## 4. Create pull request, ask for a review, address the feedback

1. You can use proprietary cli, e.g. [gh](/apps/git/cli-gh.html) or [glab](/apps/git/cli-glab.html), to create a PR. Or you can use the web GUI offered by the repo's host.
I like for the PR title to start with the issue.  In this case the PR title would be:
```
foobar-123: fix: foo.c to tolerate invalid input
```
2. Forward the request to [review](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews) your newly-created PR appropriately.
3. Go through the review cycle and address the feedback.

At this phase you many need to:

* [resolve merge conflicts](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/addressing-merge-conflicts/about-merge-conflicts);
* [rebase your branch](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase).

## 5. Merge the pull request

It could be:

* you who is responsible for the PR merge, or
* it could be someone else, or
* it can be automated.

In any case, consider [squashing the commits](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/about-pull-request-merges#squash-and-merge-your-commits) in the PR.

## Improve the process

* customize your IDE settings and use extensions.  I use [vscode](/apps/vscode/).
* use [git hooks, pre-commit hook, custom git merge driver](/apps/git/).
* learn about various [git workflows](https://www.atlassian.com/git/tutorials/comparing-workflows).
