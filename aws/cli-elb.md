# AWS Elastic Load Balancer

[Commands](https://docs.aws.amazon.com/cli/latest/reference/elbv2/).

```
> aws elbv2 describe-target-health \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:123456789:targetgroup/foobar/9084d713e791e1df
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


See also `describe-network-interfaces` in [ec2](./cli-ec2.html).
