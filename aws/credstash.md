# Credstash

[GitHub repo](https://github.com/fugue/credstash)

## Installation and Setup

0. (Linux only) Install dependencies

1. Install it

```sh
pip install credstash
```

2. Set up a key called `credstash` in KMS (found in the IAM console)

3. Make sure you have AWS creds in a place that boto/botocore can read them

4. Set it up

```sh
credstash setup
```

### ~/.credstash

Example:
```json
{
    "kms-region":"us-east-1"
}
```

## Use

### Adding secrets

Make a global secret.  Will not overwrite the existing secret!
See the repo README about versioning secrets.

`credstash put <secret-name> <secret-data>`

### Reading secrets

This will print to STDOUT.

`credstash get <secret-name>`

You can also use
[encryption contexts](http://docs.aws.amazon.com/kms/latest/developerguide/encrypt-context.html)
to limit/modify access.

### Full Example

Store private file `asokolsky_kp.pem`, retrieve it, delete secret:

```sh
credstash setup
credstash put asokolsky_kp @asokolsky_kp.pem
credstash get asokolsky_kp
credstash delete asokolsky_kp
```

### Giving access

If user/app needs to be able to encrypt/decrypt, they need to be given key usage
rights to the ‘credstash’ IAM master key.  A user (and never a production app!)
only needs key admin rights if they need to be able to add users, revoke and
regenerate the key, etc.  For read access, the credstash-read-secrets IAM role
is needed.  For secret creation access, use the credstash-write-secrets IAM
role.

### Separating secrets

By default, the ‘credstash’ KMS key and the ‘credential-store’ DynamoDB table
are used for access and storing secrets.  You can create additional keys and
tables to allow separation and compartmentalization of secrets.  For example,
creating a ‘credstash-prod’ KMS key and ‘production-credentials’ table and
giving rights (through instance roles) to applications on production instances
that need to get keys, etc.

You can also use
[encryption contexts](http://docs.aws.amazon.com/kms/latest/developerguide/encrypt-context.html)
to limit/modify access.

## Architecture (HOW this works)

[AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
provides the secure encryption key management.

Encrypted items are stored in the
[AWS DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)
table `credential-store`. We can create additional tables for access separation.

## Caveats

The data to be encrypted must be less than 4096 bytes, because of the size of
the KMS key.  If the data is larger, you can always encrypt a larger encryption
key and deliver the actual data already encrypted with that.

Secrets are “global” to all org users with credstash IAM key usage rights unless
they are created with encryption contexts.  However, you can use different
DynamoDB tables for different credentials, and limit access to those with
different policies.

## Current AWS IAM policies

credstash-read-secrets - read only, uses default credstash DDB table
‘credential-store’

credstash-write-secrets - write only, uses default credstash DDB table
‘credential-store’
