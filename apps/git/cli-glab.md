# Gitlab CLI glab

[glab](https://docs.gitlab.com/ee/editor_extensions/gitlab_cli/)

Config is stored in `~/.config/glab-cli/`.

## Authentication

```
alex@p52  ~/Projects/asokolsky.gitlab.io   master  glab auth status
gitlab.com
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

TBD
