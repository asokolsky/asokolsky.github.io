# AWS Systems Manager (SSM) CLI

[reference](https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/ssm/index.html)


## Remote access

[start-session](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ssm/start-session.html)

```sh
aws ssm start-session --target "i-1234567890abcdef0"
```

Or to login as ubuntu:

```sh
aws ssm start-session --document-name AWS-StartInteractiveCommand \
    --parameters '{"command": ["sudo su ubuntu"]}' \
    --target i-0cf519030f32da9ab
```

see [ssh.sh](ssm.sh)

## Bugs

[Can't use Ctrl+Y](https://github.com/aws/session-manager-plugin/issues/29)
