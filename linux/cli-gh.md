# gh CLI

I use github cli `gh`, [docs](https://cli.github.com/manual/).
  Here is how to use different accounts for different
repos.

## Authentication

Authentication info is stored in `~/.config/gh/*.yml`.

On my office laptop `$GH_CONFIG_DIR` is not set:

```
> echo $GH_CONFIG_DIR # returns blank

```

My authentication status:

```
> gh auth status
github.com
  ✓ Logged in to github.com as asokolsky4foobar (oauth_token)
  ✓ Git operations for github.com configured to use ssh protocol.
  ✓ Token: *******************
```

## Project-specific Credentials

To use different credentials while working on a project:

```
cd project_dir/
mkdir .config
export GH_CONFIG_DIR=.config
```

Verify your credentials are null:

```
> gh auth status
You are not logged into any GitHub hosts. Run gh auth login to authenticate.
```

Establish credentials:

```
> gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: E79C-7ADD
Press Enter to open github.com in your browser...
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as asokolsky
asokolsky in ~/Projects/asokolsky.github.io [main]>
```

I also added `.config/*` to the repo's `.gitignore`.
