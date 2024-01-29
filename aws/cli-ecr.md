# AWS ECR

## ECR Repo

For all the commands below regios should be set via environment or via cli.

To create an ecr repo:

```sh
aws ecr create-repository --repository-name _name_
```

Get login and password for using it in docker login:

```sh
aws ecr get-login-password
```

Authenticate your Docker client to the Amazon ECR registry

```sh
aws ecr | docker login -u AWS -p <password_from_above_command> _repo_host_/_repo_name_
```
docker tag:

```
docker tag 7a8ba25b2d86 _repo_host_/_repo_name_:_tag_
```

docker push:
```sh
docker push _repo_host_/_repo_name_:_tag_
```

From:
https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html

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
