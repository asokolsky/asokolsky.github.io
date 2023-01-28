# Self-hosted AWS Components

Would it not be nice to host AWS on your (home) LAN?

## S3

[minio](https://min.io/) is S3-compatible and is available on TrueNAS
[Core](https://www.truenas.com/docs/core/services/s3/) and
[Scale](https://www.truenas.com/docs/scale/scaletutorials/apps/minioclustersscale/).

### CLI client

Minio works with AWS
[cli client](https://docs.min.io/docs/aws-cli-with-minio.html),
[python client](https://docs.min.io/docs/how-to-use-aws-sdk-for-python-with-minio-server.html).

Configure the client using the `aws_access_key_id` and `aws_secret_access_key`
from the `minio` install:

```sh
aws configure
aws configure set default.s3.signature_version s3v4
```

Verify the install:
```
> aws --endpoint-url https://nass:9000 s3 ls

SSL validation failed for https://nass:9000/ [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self signed certificate (_ssl.c:1125)

> aws --no-verify-ssl --endpoint-url https://nass:9000 s3 ls
urllib3/connectionpool.py:1043: InsecureRequestWarning: Unverified HTTPS request is being made to host 'nass'. Adding certificate verification is strongly advised. See: https://urllib3.readthedocs.io/en/1.26.x/advanced-usage.html#ssl-warnings
2022-02-22 10:41:47 bucket1
2022-02-22 10:41:47 bucket2
```

## DynamoDB

[AWS DynamoDB Local](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html).

You can run DynamoDB as a
[docker container](https://hub.docker.com/r/amazon/dynamodb-local).
Alternatively.....

### Installation in an LXC Container

In LXC container:

```
apt update
apt upgrade
```

Install OpenJDK JRE:
```sh
apt install default-jre
```

Verify:
```console
root@dynamo:~# java -version
openjdk version "11.0.14" 2022-01-18
OpenJDK Runtime Environment (build 11.0.14+9-Ubuntu-0ubuntu2.20.04)
OpenJDK 64-Bit Server VM (build 11.0.14+9-Ubuntu-0ubuntu2.20.04, mixed mode, sharing)
```

Install
[DynamoDB Local](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html):
```sh
wget https://s3.us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz
mkdir -p /usr/lib/dynamodb
mv dynamodb_local_latest.tar.gz /usr/lib/dynamodb
cd /usr/lib/dynamodb
tar xfz dynamodb_local_latest.tar.gz
```

Run it:
```
java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
```

Make it a service.  Create `/etc/systemd/system/dynamodb.service`:

```
[Unit]
Description=Dynamo DB Local Service
[Service]
User=root
# The configuration file application.properties should be here:
#change this to your workspace
WorkingDirectory=/usr/lib/dynamodb
#path to executable.
#executable is a bash script which calls jar file
ExecStart=/usr/lib/dynamodb/dynamodb
SuccessExitStatus=143
TimeoutStopSec=10
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target
```

Create `/usr/lib/dynamodb/dynamodb`:

```sh
#!/bin/sh
sudo /usr/bin/java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
```

Register the service:
```sh
systemctl daemon-reload
systemctl enable dynamodb
systemctl start dynamodb
```


### Use

https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.UsageNotes.html


```cmd
PS C:\Users\asoko> aws dynamodb list-tables --endpoint-url http://dynamo:8000
{
    "TableNames": []
}
PS C:\Users\asoko>
```
