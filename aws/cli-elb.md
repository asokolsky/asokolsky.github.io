# AWS Elastic Load Balancer

[Commands](https://docs.aws.amazon.com/cli/latest/reference/elbv2/).

Context:
```sh
export TGARN=arn:aws:elasticloadbalancing:us-east-1:123456789:targetgroup/foo-bar-rds-5432/7e35f3624c3b5626
```

## describe-target-groups

```
> aws elbv2 describe-target-groups --target-group-arns $TGARN
{
    "TargetGroups": [
        {
            "TargetGroupArn": "arn:aws:elasticloadbalancing:us-east-1:123456789:targetgroup/foo-bar-rds-5432/7e35f3624c3b5626",
            "TargetGroupName": "foo-bar-rds-5432",
            "Protocol": "TCP",
            "Port": 5432,
            "VpcId": "vpc-3cf48c45",
            "HealthCheckProtocol": "TCP",
            "HealthCheckPort": "traffic-port",
            "HealthCheckEnabled": true,
            "HealthCheckIntervalSeconds": 30,
            "HealthCheckTimeoutSeconds": 10,
            "HealthyThresholdCount": 2,
            "UnhealthyThresholdCount": 2,
            "LoadBalancerArns": [
                "arn:aws:elasticloadbalancing:us-east-1:123456789:loadbalancer/net/foo-bar/c052cd3f56543b22"
            ],
            "TargetType": "ip",
            "IpAddressType": "ipv4"
        }
    ]
}
```

## describe-target-health

```
> aws elbv2 describe-target-health --target-group-arn $TGARN
{
    "TargetHealthDescriptions": [
        {
            "Target": {
                "Id": "10.7.130.177",
                "Port": 5432,
                "AvailabilityZone": "us-east-1d"
            },
            "HealthCheckPort": "5432",
            "TargetHealth": {
                "State": "unused",
                "Reason": "Target.NotInUse",
                "Description": "Target group is not configured to receive traffic from the load balancer"
            }
        }
    ]
}
```

## modify-target-group

```
aws elbv2 modify-target-group --target-group-arn $TGARN \
    --health-check-protocol HTTPS \
    --health-check-port 443 \
    --health-check-path / \
    --matcher HttpCode='200'
{
    "TargetGroups": [
        {
            "TargetGroupArn": "arn:aws:elasticloadbalancing:us-east-1:123456789:targetgroup/foo-bar-rds-5432/7e35f3624c3b5626",
            "TargetGroupName": "foo-bar-rds-5432",
            "Protocol": "TCP",
            "Port": 5432,
            "VpcId": "vpc-3cf48c45",
            "HealthCheckProtocol": "HTTPS",
            "HealthCheckPort": "443",
            "HealthCheckEnabled": true,
            "HealthCheckIntervalSeconds": 30,
            "HealthCheckTimeoutSeconds": 10,
            "HealthyThresholdCount": 2,
            "UnhealthyThresholdCount": 2,
            "HealthCheckPath": "/",
            "Matcher": {
                "HttpCode": "200"
            },
            "LoadBalancerArns": [
                "arn:aws:elasticloadbalancing:us-east-1:123456789:loadbalancer/net/foo-bar/c052cd3f56543b22"
            ],
            "TargetType": "ip",
            "IpAddressType": "ipv4"
        }
    ]
}
```
See also `describe-network-interfaces` in [ec2](./cli-ec2.html).
