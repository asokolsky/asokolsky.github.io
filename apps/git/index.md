# git

## Global Config

Followed
[Customizing Git Configuration](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration).

```
git config --global user.name "Alex Sokolsky"
git config --global user.email "asokolsky@gmail.com"
git config --global core.pager ''
git config --global core.excludesfile ~/.gitignore_global
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

## pre-commit Hook

References:

* [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
* [Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
* [pre-commit](https://pre-commit.com/#intro)
* [commitizen](https://commitizen-tools.github.io/commitizen/)

```sh
brew install pre-commit commitizen
```

```sh
pre-commit install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push
```

Create you own version of
[.pre-commit-config.yaml](https://github.com/pre-commit/pre-commit/blob/main/.pre-commit-config.yaml):

```yaml
repos:
- repo: https://github.com/pre-commit/pre-commit-hooks
  rev: v4.4.0
  hooks:
    - id: check-added-large-files
    - id: check-json
    - id: check-merge-conflict
    - id: check-yaml
    - id: end-of-file-fixer
    - id: trailing-whitespace
- repo: https://github.com/rhysd/actionlint
  rev: v1.6.25
  hooks:
    - id: actionlint-docker
- repo: https://github.com/commitizen-tools/commitizen
  rev: v3.12.0
  hooks:
    - id: commitizen
    - id: commitizen-branch
      stages: [ pre-push ]
```
