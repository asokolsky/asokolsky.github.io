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

Create you own version of [.pre-commit-config.yaml](https://github.com/pre-commit/pre-commit/blob/main/.pre-commit-config.yaml):

```yaml
{% include_relative dot-pre-commit-config.yaml %}
```
