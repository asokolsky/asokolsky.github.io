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

Note we are talking here about two entities:

* API splitting the results in pages - to limit response to just one page use
`--no-paginate`
* CLI pagination of the output:
setting [cli_pager](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html#cli-usage-pagination-clipager),
environment variable [AWS_PAGER](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html#cli-usage-pagination-awspager),
cli option [--no-cli-pager](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html#cli-usage-pagination-noclipager)

It helps me to [disable
pagination](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html)
in `~/.aws/credentials`:

```
[default]
cli_pager=
```

or just
```sh
export AWS_PAGER=''
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


## Filtering

From [cli-usage-filter](https://docs.aws.amazon.com/cli/v1/userguide/cli-usage-filter.html):

* use `--filter` or `--filters` for server-side filtering
* use `--query` for the client-side filtering with
[JMESPath syntax](https://jmespath.org/)

e.g.:
```sh
aws ec2 describe-vpn-connections \
    --filter 'Name=vpn-connection-id,Values=vpn-176b7876' \
    --query 'VpnConnections[0].CustomerGatewayConfiguration'
```

## More

* [Elastic Compute Cloud (EC2)](cli-ec2.html)
* [Elastic Container Registry (ECR)](cli-ecr.html)
* [Elastic Kubernetes Service (EKS)](cli-eksctl.html)
* [Lambda](cli-lambda.html)
* [Resource Access Manager (RAM)](cli-ram.html)
* [Route53](cli-route53.html)
* [Simple Storage Service (S3)](cli-s3.html)
* [Secrets Manager](cli-secrets.html)
* [Simple Queue Service (SQS)](cli-sqs.html)
* [Systems Manager (SSM)](cli-ssm.html)
* [Security Token Service (STS)](cli-sts.html)
