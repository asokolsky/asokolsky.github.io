# AWS ECR

## Retag an image

From https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-retag.html

Get the image manifest:
```sh
MANIFEST=$(aws ecr batch-get-image --repository-name amazonlinux --image-ids imageTag=latest --output text --query 'images[].imageManifest')
```
Use the `--image-tag` option to put the image manifest to Amazon ECR with a new
tag:

```sh
aws ecr put-image --repository-name amazonlinux --image-tag 2017.03 --image-manifest "$MANIFEST"
```

Verify that your new image tag is attached to your image:

```sh
aws ecr describe-images --repository-name amazonlinux
```
