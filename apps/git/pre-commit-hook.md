# pre-commit Hook

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
