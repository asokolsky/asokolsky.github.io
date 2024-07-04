# AWS Secrets Manager CLI

[reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/#cli-aws-secretsmanager)


## Create Secret

[reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/create-secret.html):
```sh
aws secretsmanager create-secret \
    --name pass-secret \
    --description "Secrets for pass-secret repo" \
    --secret-string file:///home/alex/Projects/pass-secret/app/secrets.json
```

## Describe secret

[reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/describe-secret.html):

```sh
aws secretsmanager describe-secret --secret-id pass-secret
```

## Retrieve secret

[reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/get-secret-value.html)

```sh
aws secretsmanager get-secret-value --secret-id pass-secret
```
or better yet
```sh
aws secretsmanager get-secret-value --secret-id pass-secret|jq ".SecretString"
```

## Delete Secret

Delete a secret. You can recover the secret with `restore-secret` until the
date and time in the `DeletionDate` response field. To delete a secret that is
replicated to other regions, first remove its replicas with
`remove-regions-from-replication`, and then call `delete-secret`:
```sh
aws secretsmanager delete-secret --secret-id pass-secret \
    --recovery-window-in-days 7
```

Force immediate secret removal:
```sh
aws secretsmanager delete-secret --secret-id pass-secret \
    --force-delete-without-recovery
```

The following deletes a replica secret in `eu-west-3`. To delete a primary
secret replicated to other regions, first delete the replicas and then call
delete-secret.
```sh
aws secretsmanager remove-regions-from-replication --secret-id pass-secret \
    --remove-replica-regions eu-west-3
```
