# AWS Security Token Service (STS)

[reference](https://awscli.amazonaws.com/v2/documentation/api/2.8.7/reference/sts/index.html#cli-aws-sts)

## get-caller-identity

```sh
aws sts get-caller-identity
```

## assume-role

```sh
aws sts assume-role --role-arn "arn:aws:iam::123456789012:role/example-role" \
    --role-session-name AWSCLI-Session
```
