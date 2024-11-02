# AWS Simple Storage Service (S3) CLI

## All the Buckets

List all the buckets in the current account:
```sh
aws s3 ls
```

## Bucket - Create, Delete, Describe, Get Attributes

To create a bucket:
```sh
export BUCKET=foo-bar
aws s3api create-bucket --bucket $BUCKET --region us-east-1 \
    --acl bucket-owner-full-control
```

To describe the bucket:
```sh
aws macie2 describe-buckets --criteria '{"bucketName":{"eq":["$BUCKET"]}}'
```

To delete the bucket:
```sh
aws s3api delete-bucket --bucket $BUCKET
```

More:
```sh
aws s3api get-bucket-policy --bucket $BUCKET
aws s3api get-bucket-cors --bucket $BUCKET
aws s3api get-bucket-location --bucket $BUCKET
aws s3api get-bucket-versioning --bucket $BUCKET
```

## Bucket Objects

To list the bucket objects in the root:
```sh
aws s3 ls s3://$BUCKET/
```

To upload the object into the bucket:
```sh
aws s3 mv delete-me.txt s3://$BUCKET/delete-me.txt
```

To download the bucket object:
```sh
aws s3 cp s3://$BUCKET/foo.tgz /tmp/foo.tgz
```

To dump the object to stdout:
```sh
aws s3 cp s3://$BUCKET/foo.json -
```
