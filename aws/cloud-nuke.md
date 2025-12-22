# Cloud Nuke

https://github.com/gruntwork-io/cloud-nuke

## Install

```sh
brew install cloud-nuke
```

## Use

```sh
> cloud-nuke -h
NAME:
   cloud-nuke - A CLI tool to nuke (delete) cloud resources.

USAGE:
   cloud-nuke [global options] command [command options] [arguments...]

VERSION:
   v0.11.3

AUTHOR:
   Gruntwork <www.gruntwork.io>

COMMANDS:
   aws           BEWARE: DESTRUCTIVE OPERATION! Nukes AWS resources (ASG, ELB, ELBv2, EBS, EC2, AMI, Snapshots, Elastic IP, RDS, Lambda Function).
   defaults-aws  Nukes AWS default VPCs and permissive default security group rules. Optionally include/exclude specified regions, or just nuke security group rules (not default VPCs).
   help, h       Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h     show help
   --version, -v  print the version
asokolsky in ~/Projects/doc > cloud-nuke aws --list-resource-types
accessanalyzer
acmpca
ami
asg
cloudwatch-dashboard
cloudwatch-loggroup
dynamodb
ebs
ec2
ecscluster
ecsserv
eip
ekscluster
elasticache
elb
elbv2
iam
kmscustomerkeys
lambda
lc
nat-gateway
oidcprovider
opensearchdomain
rds
s3
secretsmanager
snap
sqs
transit-gateway
transit-gateway-attachment
transit-gateway-route-table
vpc
```
