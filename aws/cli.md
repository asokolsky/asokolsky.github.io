# AWS CLI Client

Sources:

* [Cheatsheet](https://www.bluematador.com/learn/aws-cli-cheatsheet)
* [Reference](https://docs.aws.amazon.com/cli/latest/reference/)
* [User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)

## Install

Following [instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html):

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Enable [auto complete](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html) - I added these to my `.zshrc`:
```sh
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
```

## Use

Verify the version:
```sh
$ aws --version
aws-cli/2.4.29 Python/3.8.8 Linux/5.13.0-37-generic exe/x86_64.linuxmint.20 prompt/off
```

or on Windows:
```cmd
PS C:\Users\asoko> aws --version
aws-cli/2.5.2 Python/3.9.11 Windows/10 exe/AMD64 prompt/off
```

[Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html),
e.g. for local use:

```
PS C:\Users\asoko> aws configure
AWS Access Key ID [None]: keyid
AWS Secret Access Key [None]: accesskey
Default region name [None]: us-west-1
Default output format [None]:
```

### Pagination

It helps me to [disable
pagination](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html)
in `~/.aws/credentials`:

```
[default]
cli_pager=
```

## Environment Variables

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html

## Controlling command output

Topics:

* [output format](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-output-format.html),
note `--output table` and `--no-cli-pager `
* [pagination](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html)
* For discussion of `--query` vs `--filter` see
[Filtering AWS CLI output](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html)

```console
$ aws ec2 describe-volumes --profile dev --output table \
    --no-cli-pager \
    --query 'sort_by(Volumes, &VolumeId)[].{VolumeId: VolumeId, VolumeType: VolumeType, InstanceId: Attachments[0].InstanceId, State: Attachments[0].State}'
----------------------------------------------------------------------------
|                              DescribeVolumes                             |
+----------------------+-----------+-------------------------+-------------+
|      InstanceId      |   State   |        VolumeId         | VolumeType  |
+----------------------+-----------+-------------------------+-------------+
|  i-06253db1de27a1472 |  attached |  vol-0034927f6d89a987c  |  gp3        |
|  i-0c9e0188fe0105ed6 |  attached |  vol-0ad69e58bb689838e  |  gp2        |
|  i-081d9511ae174ebb2 |  attached |  vol-0cf1ecc29edae56d4  |  gp3        |
|  i-0c9e1235fe0666ed6 |  attached |  vol-0fbe38a5b1656f575  |  gp3        |
+----------------------+-----------+-------------------------+-------------+
```

[More](https://github.com/KarnGusain/AWS/blob/main/AWS%20CLI.md)

## Key-pair Create/Delete

Begin with:

```sh
export AWS_PROFILE=default
```

Create the key-pair:
```
aws ec2 create-key-pair --key-name _name_ --key-type ed25519 \
    --query "KeyMaterial" --output text > _name_.pem
```

then:
```
chmod 400 _name_.pem
```

To create a `.pub` public key from `.pem`:
```
ssh-keygen -y -f _name_.pem > _name_.pub
```

Delete the key-pair:
```sh
aws ec2 delete-key-pair --key-name _name_
```

## Resource Access Manager (RAM)

[Commands](https://docs.aws.amazon.com/cli/latest/reference/ram/)


[List resources](https://docs.aws.amazon.com/cli/latest/reference/ram/list-resources.html):

```sh
aws ram list-resources --resource-owner SELF
```

```sh
aws ram list-resources --resource-owner OTHER-ACCOUNTS
```


[Delete resource share](https://docs.aws.amazon.com/cli/latest/reference/ram/delete-resource-share.html):

```
aws ram delete-resource-share --resource-share-arn _arn_
```

## Route53


[Commands](https://docs.aws.amazon.com/cli/latest/reference/route53/)


[list-hosted-zones](https://docs.aws.amazon.com/cli/latest/reference/route53/list-hosted-zones.html)

```sh
aws route53 list-hosted-zones
```

[delete-hosted-zones](https://docs.aws.amazon.com/cli/latest/reference/route53/delete-hosted-zone.html)

```sh
aws route53 delete-hosted-zone --id /hostedzone/_id_
```

## Secrets Manager

[cli-aws-secretsmanager](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/#cli-aws-secretsmanager)


Start with
[create-secret](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/create-secret.html):
```sh
aws secretsmanager create-secret \
    --name pass-secret \
    --description "Secrets for pass-secret repo" \
    --secret-string file:///home/alex/Projects/pass-secret/app/secrets.json
```

You can then issue
[describe-secret](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/describe-secret.html):

```sh
aws secretsmanager describe-secret --secret-id pass-secret
```

And then
[get-secret-value](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/get-secret-value.html)

```sh
aws secretsmanager get-secret-value --secret-id pass-secret
```
or better yet
```
aws secretsmanager get-secret-value --secret-id pass-secret|jq ".SecretString"
```

## More

* [EC2](./cli-ec2.md)
* [ECR](./cli-ecr.md)
* [Lambda](./cli-lambda.md)
* [S3](./cli-s3.md)
* [SQS](./cli-sqs.md)
* [SSM](./cli-ssm.md)
