# AWS Elastic Compute Cloud (EC2) CLI

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

## Instances

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

## Auto Scaling Group

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

## Transit Gateway Attachment, VPC vs Peering

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


## VPCs

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


## Subnets

[describe-subnets](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-subnets.html)

```
aws ec2 describe-subnets
```

then [delete-subnet](https://docs.aws.amazon.com/cli/latest/reference/ec2/delete-subnet.html)
```
aws ec2 delete-subnet --subnet-id _id_
```

## Find Load Balancer IP

From
https://repost.aws/knowledge-center/elb-find-load-balancer-ip

```sh
aws ec2 describe-network-interfaces \
  --filters Name=description,Values="ELB elb-name" \
  --query 'NetworkInterfaces[*].PrivateIpAddresses[*].PrivateIpAddress' \
  --output text
```
