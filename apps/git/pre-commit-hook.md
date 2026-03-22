# pre-commit Hook

References:

* [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
* [Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
* [pre-commit](https://pre-commit.com/#intro), [repo](https://github.com/pre-commit/pre-commit)
* [commitizen](https://commitizen-tools.github.io/commitizen/)
* [ripsecrets](https://github.com/sirwart/ripsecrets)
* [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)

You can install pre-commit globally or into venv.

## Global Installation

Install the toolchain globally:

```sh
brew install pre-commit commitizen ripsecrets markdownlint-cli2
```

On Linux:

```sh
sudo apt install pre-commit
```

In every repository install the hooks:

```sh
pre-commit install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push
```

Create you own version of [.pre-commit-config.yaml](https://github.com/pre-commit/pre-commit/blob/main/.pre-commit-config.yaml):

```yaml
{% include_relative dot-pre-commit-config.yaml %}
```

To uninstall the hooks:

```sh
pre-commit uninstall
```

## Installation into venv

When using pre-commit with this repo I bumped into [this bug](https://bugs.launchpad.net/ubuntu/+source/nodeenv/+bug/2091101) and thought about using pre-commit on this repo from venv:

```sh
make pre-commit-install
```
