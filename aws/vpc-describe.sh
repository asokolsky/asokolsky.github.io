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
