# Self-hosted AWS

Would it not be nice to host AWS on your (home) LAN?

## AWS CLI Client

[Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html):

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
Verify the version:
```
aws --version
aws-cli/2.4.29 Python/3.8.8 Linux/5.13.0-37-generic exe/x86_64.linuxmint.20 prompt/off
```

## S3

[minio](https://min.io/) is S3-compatible and is
[available on TrueNAS](https://www.truenas.com/docs/core/services/s3/).
It works with AWS
[cli client](https://docs.min.io/docs/aws-cli-with-minio.html),
[python client](https://docs.min.io/docs/how-to-use-aws-sdk-for-python-with-minio-server.html).

Configure the install using the `aws_access_key_id` and `aws_secret_access_key`
from the minio install:

```sh
aws configure
aws configure set default.s3.signature_version s3v4
```

Verify the install:
```
alex@latitude7490:/tmp/ > aws --endpoint-url https://nass:9000 s3 ls

SSL validation failed for https://nass:9000/ [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self signed certificate (_ssl.c:1125)

alex@latitude7490:/tmp/ > aws --no-verify-ssl --endpoint-url https://nass:9000 s3 ls
urllib3/connectionpool.py:1043: InsecureRequestWarning: Unverified HTTPS request is being made to host 'nass'. Adding certificate verification is strongly advised. See: https://urllib3.readthedocs.io/en/1.26.x/advanced-usage.html#ssl-warnings
2022-02-22 10:41:47 bucket1
2022-02-22 10:41:47 bucket2
```

## DynamoDB

[AWS DynamoDB Local](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html)

### Installation

In LXC container:

```
apt update
apt upgrade
```

Install OpenJDK JRE:
```
apt install default-jre
```

Verify:
```
root@dynamo:~# java -version
openjdk version "11.0.14" 2022-01-18
OpenJDK Runtime Environment (build 11.0.14+9-Ubuntu-0ubuntu2.20.04)
OpenJDK 64-Bit Server VM (build 11.0.14+9-Ubuntu-0ubuntu2.20.04, mixed mode, sharing)
```

Install [DynamoDB
Local](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html):
```
wget https://s3.us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz
tar xfz dynamodb_local_latest.tar.gz
```

Run it:
```
java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
```

### Use

https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.UsageNotes.html
