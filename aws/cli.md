# AWS CLI Client

Sources:

* [Cheatsheet](https://www.bluematador.com/learn/aws-cli-cheatsheet)
* [Reference](https://docs.aws.amazon.com/cli/latest/reference/)
* [User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)

## Install

Following [instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html):

```sh
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Enable [auto complete](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html) - I added these to my `.zshrc`:
```sh
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
```

## Use

Verify the version:
```sh
$ aws --version
aws-cli/2.4.29 Python/3.8.8 Linux/5.13.0-37-generic exe/x86_64.linuxmint.20 prompt/off
```

or on Windows:
```cmd
PS C:\Users\asoko> aws --version
aws-cli/2.5.2 Python/3.9.11 Windows/10 exe/AMD64 prompt/off
```

[Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html),
e.g. for local use:

```
PS C:\Users\asoko> aws configure
AWS Access Key ID [None]: keyid
AWS Secret Access Key [None]: accesskey
Default region name [None]: us-west-1
Default output format [None]:
```

### Pagination

It helps me to [disable
pagination](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html)
in `~/.aws/credentials`:

```
[default]
cli_pager=
```

## Environment Variables

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html

## Controlling command output

Topics:

* [output format](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-output-format.html),
note `--output table` and `--no-cli-pager `
* [pagination](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html)
* For discussion of `--query` vs `--filter` see
[Filtering AWS CLI output](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-filter.html)

```console
(awscliv2) $ aws ec2 describe-volumes --profile dev --output table \
    --no-cli-pager \
    --query 'sort_by(Volumes, &VolumeId)[].{VolumeId: VolumeId, VolumeType: VolumeType, InstanceId: Attachments[0].InstanceId, State: Attachments[0].State}'
----------------------------------------------------------------------------
|                              DescribeVolumes                             |
+----------------------+-----------+-------------------------+-------------+
|      InstanceId      |   State   |        VolumeId         | VolumeType  |
+----------------------+-----------+-------------------------+-------------+
|  i-06253db1de27a1472 |  attached |  vol-0034927f6d89a987c  |  gp3        |
|  i-0c9e0188fe0105ed6 |  attached |  vol-0ad69e58bb689838e  |  gp2        |
|  i-081d9511ae174ebb2 |  attached |  vol-0cf1ecc29edae56d4  |  gp3        |
|  i-0c9e1235fe0666ed6 |  attached |  vol-0fbe38a5b1656f575  |  gp3        |
+----------------------+-----------+-------------------------+-------------+
```

[More](https://github.com/KarnGusain/AWS/blob/main/AWS%20CLI.md)

## Key-pair Create/Delete

Begin with:

```sh
export AWS_PROFILE=default
```

Create the key-pair:
```
aws ec2 create-key-pair --key-name _name_ --key-type ed25519 \
    --query "KeyMaterial" --output text > _name_.pem
```

then:
```
chmod 400 _name_.pem
```

To create a `.pub` public key from `.pem`:
```
ssh-keygen -y -f _name_.pem > _name_.pub
```

Delete the key-pair:
```sh
aws ec2 delete-key-pair --key-name _name_
```

## S3

```
aws s3 ls
```

## EC2

### Instances

[describe-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html)

```sh
aws ec2 describe-instances --instance-ids _id_
```

A more practical approach:

1. Define a shell alias function:

```sh
#
# add this to you .zshprofile
#
function refresh_ec2_instances()
{
    okta-aws default sts get-caller-identity > /dev/null
    aws ec2 describe-instances --region=us-east-1 \
        --query 'Reservations[*].Instances[*].{Id:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,Image:ImageId,Type:InstanceType,VPC:VpcId,AZ:Placement.AvailabilityZone,Subnet:SubnetId,PriIP\
:PrivateIpAddress,PubIP:PublicIpAddress,IAM:IamInstanceProfile.Arn,Launched:LaunchTime,State:State.Name}' \
        --output table | sed -e 's/arn:.*\///' > $HOME/.ec2instances.txt
    echo "$HOME/.ec2instances.txt updated"
}
```

2. Call this function at shell prompt to update `~/.ec2instances.txt`

3. Search the `~/.ec2instances.txt` for IPs

```sh
# find IPs of instances of interest:
grep _name_ ~/.ec2instances.txt | awk -F\| '{print $8}'| sed 'H;1h;$!d;x;y/\n/,/'| sed 's/ //g'
```

To execute command on multiple instances, e.g. `sudo docker ps -a `:

```sh
pdsh -w $(grep _name_ ~/.ec2instances.txt | awk -F\| '{print $8}' | sed 'H;1h;$!d;x;y/\n/,/' | sed -e 's/ //g') 'sudo docker ps -a '
```

[terminate-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/terminate-instances.html)

```sh
TBD
```

Find the instance by an IP:
```sh
aws ec2 describe-instances --filter Name=private-ip-address,Values=$ip
```

Find the instance by name:
```sh
aws ec2 describe-instances --filter Name=tag:Name,Values=$name
```

### Auto Scaling Group

Special case for instance termination when the instance belongs to an ASG - use
[terminate-instance-in-auto-scaling-group](https://docs.aws.amazon.com/cli/latest/reference/autoscaling/terminate-instance-in-auto-scaling-group.html) -
you also need to specify whether desired capacity should be changed.

```sh
aws autoscaling terminate-instance-in-auto-scaling-group --instance-id  _id_ --should-decrement-desired-capacity
```

### Transit Gateways

[describe-transit-gateways](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-transit-gateways.html)

```sh
aws ec2 describe-transit-gateways
```

and then
[delete-transit-gateway](https://docs.aws.amazon.com/cli/latest/reference/ec2/delete-transit-gateway.html)

```sh
aws ec2 delete-transit-gateway --transit-gateway-id <value>
```

### Route Tables vs Transit Gateway Route Tables

Note that
[describe-route-tables](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-route-tables.html)
and
[describe-transit-gateway-route-tables](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-transit-gateway-route-tables.html)
operate on different types of objects!

```sh
aws ec2 describe-route-tables
```

```
aws ec2 describe-transit-gateway-route-tables --transit-gateway-route-table-ids _id_
```

### Transit Gateway Attachment, VPC vs Peering

[describe-transit-gateway-attachments](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-transit-gateway-attachments.html)

```
aws ec2 describe-transit-gateway-attachments
```

and then
[delete-transit-gateway-vpc-attachment]

```
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id _id_
```

To locate attachments to a TGW by id:
```sh
aws ec2 describe-transit-gateway-attachments --filters Name=transit-gateway-id,Values=_id_
```


### VPCs

[describe-vpcs](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-vpcs.html)

```
aws ec2 describe-vpcs
```

then [delete-vpc](https://docs.aws.amazon.com/cli/latest/reference/ec2/delete-vpc.html)
only after you delete all the gateways and resources associated with the VPC.
```
aws ec2 delete-vpc --vpc-id _id_
```

[finding VPC dependencies](https://aws.amazon.com/premiumsupport/knowledge-center/troubleshoot-dependency-error-delete-vpc/)
see [vpc-describe.sh](vpc-describe.sh)


```
#!/bin/bash
#
# vpc-describe.sh
#
vpc="_id_"
region="us-east-1"
profile="default"
#aws --profile $profile ec2 describe-vpc-peering-connections --region $region --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc | grep VpcPeeringConnectionId
aws --profile $profile ec2 describe-vpc-peering-connections --region $region --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc
#aws --profile $profile ec2 describe-nat-gateways --region $region --filter 'Name=vpc-id,Values='$vpc | grep NatGatewayId
aws --profile $profile ec2 describe-nat-gateways --region $region --filter 'Name=vpc-id,Values='$vpc
#aws --profile $profile ec2 describe-instances --region $region --filters 'Name=vpc-id,Values='$vpc | grep InstanceId
aws --profile $profile ec2 describe-instances --region $region --filters 'Name=vpc-id,Values='$vpc
#aws --profile $profile ec2 describe-vpn-gateways --region $region --filters 'Name=attachment.vpc-id,Values='$vpc | grep VpnGatewayId
aws --profile $profile ec2 describe-vpn-gateways --region $region --filters 'Name=attachment.vpc-id,Values='$vpc
#aws --profile $profile ec2 describe-network-interfaces --region $region --filters 'Name=vpc-id,Values='$vpc | grep NetworkInterfaceId
aws --profile $profile ec2 describe-network-interfaces --region $region --filters 'Name=vpc-id,Values='$vpc
```


### Subnets

[describe-subnets](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-subnets.html)

```
aws ec2 describe-subnets
```

then [delete-subnet](https://docs.aws.amazon.com/cli/latest/reference/ec2/delete-subnet.html)
```
aws ec2 delete-subnet --subnet-id _id_
```

## Resource Access Manager (RAM)

[Commands](https://docs.aws.amazon.com/cli/latest/reference/ram/)


[List resources](https://docs.aws.amazon.com/cli/latest/reference/ram/list-resources.html):

```sh
aws ram list-resources --resource-owner SELF
```

```sh
aws ram list-resources --resource-owner OTHER-ACCOUNTS
```


[Delete resource share](https://docs.aws.amazon.com/cli/latest/reference/ram/delete-resource-share.html):

```
aws ram delete-resource-share --resource-share-arn _arn_
```

## Route53


[Commands](https://docs.aws.amazon.com/cli/latest/reference/route53/)


[list-hosted-zones](https://docs.aws.amazon.com/cli/latest/reference/route53/list-hosted-zones.html)

```sh
aws route53 list-hosted-zones
```

[delete-hosted-zones](https://docs.aws.amazon.com/cli/latest/reference/route53/delete-hosted-zone.html)

```sh
aws route53 delete-hosted-zone --id /hostedzone/_id_
```

## Secrets Manager

[cli-aws-secretsmanager](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/#cli-aws-secretsmanager)


Start with
[create-secret](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/create-secret.html):
```sh
aws secretsmanager create-secret \
    --name pass-secret \
    --description "Secrets for pass-secret repo" \
    --secret-string file:///home/alex/Projects/pass-secret/app/secrets.json
```

You can then issue
[describe-secret](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/describe-secret.html):

```sh
aws secretsmanager describe-secret --secret-id pass-secret
```

And then
[get-secret-value](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/secretsmanager/get-secret-value.html)

```sh
aws secretsmanager get-secret-value --secret-id pass-secret
```
or better yet
```
aws secretsmanager get-secret-value --secret-id pass-secret|jq ".SecretString"
```
