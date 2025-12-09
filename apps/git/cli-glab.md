# Gitlab CLI glab

[glab](https://docs.gitlab.com/ee/editor_extensions/gitlab_cli/)

Config is stored in `~/.config/glab-cli/`. Change it using:
```sh
glab config set
```

## Authentication

Check the status with
```sh
glab auth status
```
Produces:
```
  ✓ Logged in to gitlab.com as asokolsky (/home/alex/.config/glab-cli/config.yml)
  ✓ Git operations for gitlab.com configured to use https protocol.
  ✓ API calls for gitlab.com are made over https protocol
  ✓ REST API Endpoint: https://gitlab.com/api/v4/
  ✓ GraphQL Endpoint: https://gitlab.com/api/graphql/
  ✓ Token: **************************
```

To re-authenticate:

```sh
glab auth login
```

## Project-specific Credentials

Set [GLAB_CONFIG_DIR](https://gitlab.com/gitlab-org/cli/-/tree/main#environment-variables):

```sh
cd project_dir/
mkdir .glconfig
export GLAB_CONFIG_DIR=`pwd`/.glconfig
```
