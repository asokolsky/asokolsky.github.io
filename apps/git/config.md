# Git Config(s)

## System level

Aapplied to every user on the system and all their repositories.

* to view, `git config --list --system` (may need sudo)
* to set, `git config --system color.ui true`
* to edit system config file: `git config --edit --system`

## Global User level

Specific personally to you, the user.

* to view: `git config --list --global`
* to set: `git config --global user.name xyz`
* to edit global config file: `git config --edit --global`

## Repository level

Specific to that single repository.

* to view: `git config --list --local`
* to set: `git config [--local] core.ignorecase true`
* to edit repository config file: `git config --edit [--local]`

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

## View All Settings

Show system, global, and (if inside a repository) local configs:

```sh
git config --list
```

To also show the origin file of each config item:
```sh
git config --list --show-origin
```

To get e.g. `user.name`:

```sh
git config user.name
```

You may also specify options `--system`, `--global`, `--local` to read that
value at a particular level.


## Best Practices - Global Config

Followed [Customizing Git Configuration](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration).

```sh
git config --global user.name "Alex Sokolsky"
git config --global user.email "asokolsky@gmail.com"
git config --global core.editor /usr/bin/emacs
git config --global core.excludesfile ~/.gitignore_global
git config --global core.pager ''
git config --global push.default current
```

where `~/.gitignore_global`:
```
*~
.*.swp
.DS_Store
```
