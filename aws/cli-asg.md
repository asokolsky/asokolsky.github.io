# Auto Scaling Group

To increase ASG capacity use [update-auto-scaling-group](https://docs.aws.amazon.com/cli/latest/reference/autoscaling/update-auto-scaling-group.html):
```sh
aws autoscaling update-auto-scaling-group --auto-scaling-group-name _name_ \
    --min-size 2 --desired-capacity 3 --max-size 10
```

To terminate an instance in an ASG, use [terminate-instance-in-auto-scaling-group](https://docs.aws.amazon.com/cli/latest/reference/autoscaling/terminate-instance-in-auto-scaling-group.html) - also need to specify whether desired capacity should be changed.

```sh
aws autoscaling terminate-instance-in-auto-scaling-group --instance-id  _id_ \
    --should-decrement-desired-capacity
```
