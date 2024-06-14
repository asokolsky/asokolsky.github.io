# AWS Simple Storage Service (S3) CLI

```sh
aws s3 ls
```

```sh
export BUCKET=indexer-api-test
aws s3api create-bucket --bucket $BUCKET --region us-east-1 --acl bucket-owner-full-control
```

```sh
aws s3api get-bucket-policy --bucket $BUCKET
aws s3api get-bucket-cors --bucket $BUCKET
aws s3api get-bucket-location --bucket $BUCKET
aws s3api get-bucket-versioning --bucket $BUCKET

Also:

```sh
aws macie2 describe-buckets --criteria '{"bucketName":{"eq":["$BUCKET"]}}'
```
To delete:

```sh
aws s3api delete-bucket --bucket $BUCKET
```
To upload:
```sh
aws s3 mv delete-me.txt s3://$BUCKET/delete-me.txt
```

download:
```sh
aws s3 cp s3://bucket/foo.tgz /tmp/foo.tgz
```

To dump the object to stdout:
```sh
aws s3 cp s3://bucket/foo.json -
```
