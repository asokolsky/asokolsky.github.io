# aws-vault

[aws-vault](https://github.com/99designs/aws-vault) creates a sub-shell with
`AWS_XXX` environment variables being set after validating the user credentials.
The credentials are set by default in the MacOS key-chain.

## Installation

```sh
brew install aws-vault
```

## Configuration

Login into your IAM AWS account using MFA.  If you just set it up, log out and
then login back.

### Generate Access Keys

[Generate the keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)
for your IAM user:

* in AWS console click `Create Access Key` button, select CLI option, confirm
your choice, enter descriptive tag.
* Click `Create Access Key`
* Save values for `Access key` and `Secret access key` for use with `aws-vault`.
* Save your MFA arn - it looks like `arn:aws:iam::981970545799:mfa/_username_`.

### Update `~/.aws/config`

Create a new profile by running
```sh
aws-vault add <PROFILE_NAME>
```
where `PROFILE_NAME` is chosen by you and can be anything.

Paste in your access key and secret key when prompted.  These will be stored
in your macos keychain.

Update the `~/.aws/config`, replace the vars in `<>` with the appropriate values:
```ini
[default]
region=us-east-1

[profile <PROFILE_NAME>]
mfa_serial = <MFA_ARN>

[profile logs-from-security]
role_arn=arn:aws:iam::<LOGS_ACCOUNT_ID>:role/allow-full-access-from-other-accounts
source_profile=<PROFILE_NAME>
mfa_serial = <MFA_ARN>

[profile shared-from-security]
role_arn=arn:aws:iam::<SHARED_ACCOUNT_ID>:role/allow-full-access-from-other-accounts
source_profile=<PROFILE_NAME>
mfa_serial = <MFA_ARN>

[profile dev-from-security]
role_arn=arn:aws:iam::<DEV_ACCOUNT_ID>:role/allow-full-access-from-other-accounts
source_profile=<PROFILE_NAME>
mfa_serial = <MFA_ARN>
```

## Usage

Create a sub-shell for use with cli utils, e.g. aws or k9s:
```sh
aws-vault exec --duration=12h dev-from-security
```

Open an AWS console in your browser by entering in the sub-shell:
```sh
aws-vault login
```

## Populating profile

```
asokolsky@laptop > ~ > aws-vault list
Profile                  Credentials              Sessions
=======                  ===========              ========
default                  -                        -
asokolsky                asokolsky                -
logs-from-security       -                        -
shared-from-security     shared-from-security     sts.AssumeRole:11h49m39s
dev-from-security        dev-from-security        sts.AssumeRole:10h53m32s
prod-from-security       -                        -
stage-from-security      stage-from-security      sts.AssumeRole:11h45m28s
```
