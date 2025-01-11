# S3 Best Practices

## Disable ACL

See [Controlling Object Ownership](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) on why bucket policy should be used instead of bucket ACL.

From [How to disable S3 bucket ACLs](https://www.puppeteers.net/blog/how-to-disable-s3-bucket-acls/):

```
resource "aws_s3_bucket" "test" {
  bucket = "s3test.example.org"
}

resource "aws_s3_bucket_ownership_controls" "test" {
  bucket = aws_s3_bucket.test.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
```


Also: [Disable bucket ACL(s) in a given AWS account](https://repost.aws/questions/QUGvjWqwpuQ-S8bs6pDTecJA/disable-bucket-acl-s-in-a-given-aws-account).
