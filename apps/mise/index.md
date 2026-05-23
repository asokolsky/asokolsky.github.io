# mise

- [about](https://mise.jdx.dev/about.html)
- [demo and docs](https://mise.jdx.dev/demo.html)
- [repo](https://github.com/jdx/mise)
- with built-in [support for secrets](https://mise.jdx.dev/environments/secrets/)

## Installation

[Install it](https://mise.jdx.dev/installing-mise.html).

I use `zsh` with `oh-my-zsh` and added mise plugin to my `.zshrc`.

## Troubleshooting

### Error: usage CLI not found. This is required for completions to work in mise.

Resolution - install usage globally:

```sh
mise use -g usage
```

### WARN GitHub rate limit exceeded.

Resolution from [Troubleshooting](https://mise.jdx.dev/troubleshooting.html):
pass [a token](https://mise.jdx.dev/dev-tools/github-tokens.html#setting-a-token-via-environment-variable).
In my `.zshenv`:

```sh
export MISE_GITHUB_TOKEN="ghp_xxxxxxxx"
```

## Using mise with your repo

- with [python, python+uv](https://mise.jdx.dev/mise-cookbook/python.html)
- [in Dockerfile](../docker/mise.html)

Steps:

- establish trust:

```sh
mise trust
```

- install the toolchain as specified in `mise.toml`:

```sh
mise install
```

- you can now `mise run target` or just `mise target`
