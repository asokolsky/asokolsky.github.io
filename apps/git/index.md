# git

## Topics

* [git hooks](https://www.atlassian.com/git/tutorials/git-hooks),
[pre-commit hook](pre-commit-hook.html)
* [custom git merge driver](custom-merge-driver.html)
* [Hosting a Repo in a Cloud](hosting.html)
* [merge vs rebase workflow](workflow.html)
* [FAQs](faq.html)

And more:
* [Atlassian advanced tips](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
* [8 Easy Steps to Set Up Multiple GitHub Accounts](https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/)

## Configs

### System level

Aapplied to every user on the system and all their repositories.

* to view, `git config --list --system` (may need sudo)
* to set, `git config --system color.ui true`
* to edit system config file: `git config --edit --system`

### Global User level

Specific personally to you, the user.

* to view: `git config --list --global`
* to set: `git config --global user.name xyz`
* to edit global config file: `git config --edit --global`

### Repository level

Specific to that single repository.

* to view: `git config --list --local`
* to set: `git config [--local] core.ignorecase true`
* to edit repository config file: `git config --edit [--local]`

### View All Settings

Show system, global, and (if inside a repository) local configs:

```sh
git config --list
```


To also show the origin file of each config item:
```sh
git config --list --show-origin
```


### To read one particular config:

To get e.g. `user.name`:

```sh
git config user.name
```

You may also specify options `--system`, `--global`, `--local` to read that
value at a particular level.


## Global Config

Followed
[Customizing Git Configuration](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration).

```sh
git config --global user.name "Alex Sokolsky"
git config --global user.email "asokolsky@gmail.com"
git config --global core.editor /usr/bin/emacs
git config --global core.excludesfile ~/.gitignore_global
git config --global core.pager ''
```

where `~/.gitignore_global`:
```
*~
.*.swp
.DS_Store
```

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

## Repo-specific Config

Set repo-specific (non-global) config settings:
```sh
git config user.name "Alex Sokolsky"
git config user.email "asokolsky@gmail.com"
git config core.sshCommand "ssh -i ~/.ssh/private_key"
```

Make sure your private identity is available:
```sh
ssh-add ~/.ssh/private_key
```

Then
```sh
git remote add origin git@github.com:asokolsky/repo.git
git push --set-upstream origin master
```

## Importing a file from a different repo

Instead of using git submodules, sometimes this may make more sense:
```sh
{% include_relative update-from-repo.sh %}
```
