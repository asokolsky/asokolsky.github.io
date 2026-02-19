# Multiple GitHub Accounts

Based on [8 Easy Steps to Set Up Multiple GitHub Accounts](https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/).

The plan is:

* use ssh authentication with repo URL being `ssh`, not `https`, e.g.:
```
[remote "origin"]
        url = git@github.com:asokolsky/digital-scout.git
```
* have a common config in `~/.gitconfig` importing, depending on the project, one of:
* business project config in `~/Projects/.gitconfig`
* personal project config in  `~/PersonalProjects/.gitconfig`

## Common Config

My business laptop `~/.gitconfig`:

```
# ~/.gitconfig

[includeIf "gitdir:~/PersonalProjects/"]
path = ~/PersonalProjects/.gitconfig

[includeIf "gitdir:~/Projects/"]
path = ~/Projects/.gitconfig

[core]
        pager =
        excludesfile = ~/.gitignore
        editor = /opt/homebrew/bin/emacs

[alias]
        co = checkout

[filter "lfs"]
        clean = git-lfs clean -- %f
        smudge = git-lfs smudge -- %f
        process = git-lfs filter-process
        required = true

[init]
        defaultBranch = main

[push]
        autoSetupRemote = true
        default = current

[pull]
        rebase = true

[rebase]
        autoSquash = true
        autoStash = true
```

## Business Config

My business projects are in `~/Projects/`, my `~/Projects/.gitconfig`:
```
[user]
        email = asokolsky@company.com
        name = Alex Sokolsky

[github]
        user = asokolsky4company

[core]
        sshCommand = "ssh -i ~/.ssh/asokolsky4company.pem"
```

## Personal Config

My personal projects are in `~/PersonalProjects/`, my `~/PersonalProjects/.gitconfig`:

```
# ~/PersonalProjects/.gitconfig
[user]
        email = asokolsky@gmail.com
        name = Alex Sokolsky

[github]
        user = asokolsky

[core]
        sshCommand = "ssh -i ~/.ssh/latitude_id_rsa"
```
