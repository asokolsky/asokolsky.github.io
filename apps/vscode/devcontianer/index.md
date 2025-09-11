# vscode devcontainer

https://code.visualstudio.com/docs/devcontainers/containers

## Step by step

1. Create `.devcontainer/.env` and customize it:

```
GIT_USER_NAME='Al So'
GIT_EMAIL='also@foo.bar'
```

2. Create `.devcontainer/.gitignore`:
```
.env
```

3. Create `.devcontainer/Dockerfile`:

See, e.g. [Dockerfile for terraform](./Dockerfile-terraform.txt)
```
{% include_relative Dockerfile-terraform.txt %}
```

4. Create `.devcontainer/devcontainer.json`:
```json
{% include_relative devcontainer-terraform.json %}
```
