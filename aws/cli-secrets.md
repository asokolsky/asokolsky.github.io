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
