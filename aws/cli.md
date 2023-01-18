# AWS CLI Client

[User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)

## Install

[Instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html):

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
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

[Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html), e.g. for local use:

```
PS C:\Users\asoko> aws configure
AWS Access Key ID [None]: keyid
AWS Secret Access Key [None]: accesskey
Default region name [None]: us-west-1
Default output format [None]:
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
(awscliv2) $ aws ec2 describe-volumes --profile dev --output table \
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

More: https://github.com/KarnGusain/AWS/blob/main/AWS%20CLI.md

## Key-pair Create/Delete

Before anything:

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
