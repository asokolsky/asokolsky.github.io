# gh - Github CLI

[github manual](https://cli.github.com/manual/).

Here is how to use different accounts for different repos.

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

To re-authenticate:

```sh
gh auth login
```

## Project-specific Credentials

To use different credentials while working on a project:

```sh
cd project_dir/
mkdir .ghconfig
export GH_CONFIG_DIR=`pwd`/.ghconfig
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

I also added `.ghconfig/*` to the repo's `.gitignore`.

## gh whomi

```sh
gh api user | jq -r '"\(.name) \(.login)"'
```

## gh api

Use of GitHub API:
```sh
TEAM_NAME="foo-bar" ORG="baz"
gh api graphql -f query='
  query($org: String!, $team: String!, $after: String) {
    organization(login: $org) {
      team(slug: $team) {
        members(first: 100, after: $after) {
          pageInfo {
            hasNextPage
            endCursor
          }
          nodes {
            login
            name
          }
        }
      }
    }
  }
' -f org=$ORG -f team=$TEAM_NAME --jq '.data.organization.team.members.nodes[] | [.login, .name]| @csv'
```

## Using Multiple Accounts

1. Login into your office github account

2. Login into personal account:
```
> gh auth login
? Where do you use GitHub? GitHub.com
? What is your preferred protocol for Git operations on this host? SSH
? Upload your SSH public key to your GitHub account? /Users/asokolsky/.ssh/id_rsa.pub
? Title for your SSH key: asokolsky
? How would you like to authenticate GitHub CLI? Paste an authentication token
Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
The minimum required scopes are 'repo', 'read:org', 'admin:public_key'.
? Paste your authentication token: ****************************************
- gh config set -h github.com git_protocol ssh
✓ Configured git protocol
✓ SSH key already existed on your GitHub account: /Users/asokolsky/.ssh/id_rsa.pub
✓ Logged in as asokolsky
```

3. Confirm you logged into both, the last one (personal) is active:
```
> gh auth status
github.com
  ✓ Logged in to github.com account asokolsky (keyring)
  - Active account: true
  - Git operations protocol: ssh

  ✓ Logged in to github.com account asokolsky4foobar (keyring)
  - Active account: false
  - Git operations protocol: ssh
```

4. Switch back to office acount:
```
> gh auth switch --user asokolsky4foobar
✓ Switched active account for github.com to asokolsky4foobar

5. Confirm office acount as being active:
```
> gh auth status
github.com
  ✓ Logged in to github.com account asokolsky4foobar (keyring)
  - Active account: true
  - Git operations protocol: ssh

  ✓ Logged in to github.com account asokolsky (keyring)
  - Active account: false
  - Git operations protocol: ssh
```
