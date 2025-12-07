# git

## Topics

* [Configuration](config.html)
* [git hooks](https://www.atlassian.com/git/tutorials/git-hooks), [pre-commit hook](pre-commit-hook.html)
* [custom git merge driver](custom-merge-driver.html)
* [Hosting a Repo in a Cloud](hosting.html)
* [merge vs rebase workflow](workflow.html)
* [git squash](squash-commits.html)
* [Using Multiple GitHub Accounts](multiple-gh-accounts.html)
* [FAQs](faq.html)

And more:
* [Pro Git Book](https://git-scm.com/book/en/v2)
* [Atlassian advanced tips](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

Proprietary Extensions

* [gh CLI for github](cli-gh.html)
* [glab CLI for gitlab](cli-glab.html)

Manuals:

* [Beej's Guide to Git](https://beej.us/guide/bggit/html/)

## Handling an Upstream Repo

```
alex@latitude7490:~/Projects/psmqtt/ > git remote -v
origin  https://github.com/asokolsky/psmqtt.git (fetch)
origin  https://github.com/asokolsky/psmqtt.git (push)
upstream        https://github.com/eschava/psmqtt.git (fetch)
upstream        https://github.com/eschava/psmqtt.git (push)

alex@latitude7490:~/Projects/psmqtt/ > git status
On branch typing
Your branch is up to date with 'origin/typing'.

nothing to commit, working tree clean
```

Just pull from upstream:

```
alex@latitude7490:~/Projects/psmqtt/ > git pull upstream master
```
And then push
```
alex@latitude7490:~/Projects/psmqtt/ > git push
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/asokolsky/psmqtt.git
   a98ddea..52094f3  master -> master
```

## Importing a file from a different repo

Instead of using git submodules, sometimes this may make more sense:
```sh
{% include_relative update-from-repo.sh %}
```

## Utility Scripts

* [check-repo.sh](check-repo.sh) - check that all subdirectories are clean repos
