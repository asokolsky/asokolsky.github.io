# AWS Elastic Container Registry (ECR) CLI

[reference](https://docs.aws.amazon.com/cli/latest/reference/ecr/)

For all the commands below the region should be set via environment or via cli.

## ECR Repo

See [Pushing a Docker image to an Amazon ECR private repository](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html).

[describe-repositories](https://docs.aws.amazon.com/cli/latest/reference/ecr/describe-repositories.html)

```sh
aws ecr describe-repositories
```

To [create an ecr repo](https://docs.aws.amazon.com/cli/latest/reference/ecr/create-repository.html):

```sh
aws ecr create-repository --repository-name _name_
```

[Get login password](https://docs.aws.amazon.com/cli/latest/reference/ecr/get-login-password.html) for using it with docker:

```sh
aws ecr get-login-password
```

Next authenticate your Docker client to the Amazon ECR registry:

```sh
aws ecr | docker login -u AWS -p <password_from_above_command> _repo_host_/_repo_name_
```

Or just use this one-liner:

```sh
ECR_HOST=`aws sts get-caller-identity --query Account --output text`.dkr.ecr.`aws configure get region`.amazonaws.com \
    aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_HOST
```

To tag the image:

```
docker tag 7a8ba25b2d86 _repo_host_/_repo_name_:_tag_
```

To push the image:

```sh
docker push _repo_host_/_repo_name_:_tag_
```

## Retag an image

See [Retagging an image in Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-retag.html).

Get the image manifest:
```sh
MANIFEST=$(aws ecr batch-get-image --repository-name amazonlinux --image-ids imageTag=latest --output text --query 'images[].imageManifest')
```
Use [put-image](https://docs.aws.amazon.com/cli/latest/reference/ecr/put-image.html)
`--image-tag` option to put the image manifest to Amazon ECR with a new tag:

```sh
aws ecr put-image --repository-name amazonlinux --image-tag 2017.03 --image-manifest "$MANIFEST"
```

Verify that your new image tag is attached to your image:

```sh
aws ecr describe-images --repository-name amazonlinux
```
