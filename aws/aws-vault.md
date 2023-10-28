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

```sh
aws-vault exec dev-from-security
```
