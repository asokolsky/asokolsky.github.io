# Self-hosted AWS

Would it not be nice to host AWS on your (home) LAN?

## S3

[minio](https://min.io/) is S3-compatible and is
[available on TrueNAS](https://www.truenas.com/docs/core/services/s3/).
It works with AWS
[cli client](https://docs.min.io/docs/aws-cli-with-minio.html),
[python client](https://docs.min.io/docs/how-to-use-aws-sdk-for-python-with-minio-server.html).

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
