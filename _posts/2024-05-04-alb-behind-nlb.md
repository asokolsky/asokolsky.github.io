---
title: ALB behind an NLB Gotchas
tags: aws
---

An application load balancer
([ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html))
is deployed in Amazon Web Services (AWS) behind a network load balancer
([NLB](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html)).
In turn, behind the ALB are few pods of a kubernetes cluster:

```
NLB -> ALB -> pods
```

The reasons for such an architecture are beyond the scope of this post.

Problem statement: after the initial setup things worked as expected.  Soon(ish)
the NLB started reporting the ALB as not healthy.

Tip: consider the availability zones (AZs).

## Details

To understand the reasons for such an unexpected behavior let's dwell into the
details:

* assume NLB and ALB work only with HTTP traffic on port 80;
* there are 3 AZs;
* NLB was configured (by mistake) to reside in AZ1 and AZ2;
* there are 2 pods, one per AZ, randomly distributed between the AZs;
* NLB has the default settings with cross-az balancing disabled. Hence the NLB's
ENI specific to the AZ is connected only to the ENI of the ALB in that AZ.

Right after the installation:
```
            +-----+         +-----+
============|     |=========|     |============
            |     |         |     |
AZ1         |     o---->----o     o-->--[pod1]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ2         | NLB o---->----o ALB o-->--[pod2]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ3         |     |         o     o-->--[pod3]
            |     |         |     |
============|     |=========|     |============
            +-----+         +-----+

Legend:

  o - elastic network interface
  = - AZ boundary
```

So far so good.

After a while:

* pods can come and go as needed in different AZs. Say, there are no more pods
in AZ2.
* An AWS ALB optimization process kicks in, removing the ALB's ENIs which do not
have targets in the corresponding AZ, specifically in AZ2.
* From the NLB perspective, the health check for the ALB in AZ2 is now failing.

```
            +-----+         +-----+
============|     |=========|     |============
            |     |         |     |
AZ1         |     o---->----o     o-->--[pod1]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ2         | NLB o---->----o ALB |
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ3         |     |         o     o-->--[pod3]
            |     |         |     |
============|     |=========|     |============
            +-----+         +-----+

Legend:

  o - elastic network interface
  = - AZ boundary
```

## Lessons Learned

### NLB Settings

NLB *should* be configured:

* to have presence in all the AZs;
* to perform
[cross-az load balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-cross-zone.html).

### Optimize the ALB's Health Check

Consider the ALB target group first.  Its health checks are terminated on the
pods:

* protocol: HTTP
* port: 80
* path: `/`

Now let's talk about the health check for the target group embedding the ALB.
If we just repeat the above health check, these will be terminated on the pods.
A better solution would be to have the health checks terminated on the ALB.
To accomplish this, add a special rule to the ALB listener:

* path: `/alb-health-check`
* return fixed response: 200

```
#
# respond to the health check from NLB
#
resource "aws_lb_listener_rule" "alb_health_check" {
  listener_arn = arn
  priority     = 555

  action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "ok"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["/alb-health-check"]
    }
  }
}
```

For the target group embedding the ALB, add the above path as a health check:

* protocol: HTTP
* port: 80
* path: `/alb-health-check`

```
resource "aws_lb_target_group" "alb_target_group" {
  name = "alb_target_group"
  port = 80
  protocol = "HTTP"
  target_type = "alb"

  health_check {
    path = "/alb-health-check"
    port = 80
    protocol = "HTTP"
  }
}
```

## See Also

* how to [identify all the ALBs ENIs](https://www.linkedin.com/pulse/aws-alb-internal-external-one-instance-max-fortun-2o9we).
* [Elastic Load Balancer: Maximizing Benefits and Keeping Costs Low](https://aws.amazon.com/blogs/networking-and-content-delivery/elb-maximizing-benefits-and-keeping-costs-low/)
