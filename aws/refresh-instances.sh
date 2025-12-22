# put this into .zsh-akliases

function refresh_instances()
{
    okta-aws default sts get-caller-identity > /dev/null
    aws ec2 describe-instances --region=us-east-1 \
        --query 'Reservations[*].Instances[*].{Id:InstanceId,Name:Tags[?Key==`Name`]|[0].Value,Image:ImageId,Type:InstanceType,VPC:VpcId,AZ:Placement.AvailabilityZone,Subnet:SubnetId,PriIP:PrivateIpAddress,PubIP:PublicIpAddress,IAM:IamInstanceProfile.Arn,Launched:LaunchTime,State:State.Name}' \
        --output table | sed -e 's/arn:.*\///' > $HOME/tmp/instances-full.txt
    echo "$HOME/tmp/instances-full.txt updated"
}
#
# Then to find IPs of instances of interest:
#    grep core_queue_worker_production ~/.ec2instances-full.txt | awk -F\| '{print $8}'| sed 'H;1h;$!d;x;y/\n/,/'| sed 's/ //g'
#
