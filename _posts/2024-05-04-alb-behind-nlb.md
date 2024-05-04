---
title: AWS: ALB behind an NLB Gotchas
tags: aws
---

# AWS: ALB behind an NLB Gotchas

An application load balancer (ALB) is deployed in Amazon Web Services (AWS)
behind a network load balancer (NLB). In turn, behind the ALB are few pods of a
kubernetes cluster:

```
NLB -> ALB -> pods
```

The reasons for such an architecture are beyond the scope of this post.

Problem statement: after the initial setup things worked as expected.  Soon(ish)
the NLB started reporting the ALB as not healthy.

Tip: consider the availability zones (AZs).

To understand the reasons for such an unexpected behavior let's dwell into
details:

* assume NLB and ALB work only with HTTP traffic on port 80
* there are 3 AZs
* there are 3 pods, one per AZ
* NLB has the default settings with cross-az balancing disabled. Hence the NLB's ENI
specific to the AZ is connected only to the ENI of the ALB in that AZ.

Right after the installation:
```
============+=====+=========+=====+============
            |     |         |     |
AZ1         |     o---->----o     o-->--[pod1]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ2         | NLB o---->----o ALB o-->--[pod2]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ3         |     o---->----o     o-->--[pod3]
            |     |         |     |
============+=====+=========+=====+============

Legend:
  o - elastic network interface
  = - AZ boundary
```

So far so good.

After a while:

* pods can come and go as needed in different AZs. There are no more pods in
AZ3.
* An AWS ALB optimization process kicks in, removing the ALB's ENIs which do not
have targets in the corresponding AZ, specifically in AZ3.


```
============+=====+=========+=====+============
            |     |         |     |
AZ1         |     o---->----o     o-->--[pod1]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ2         | NLB o---->----o ALB o-->--[pod2]
            |     |         |     |
============+     +=========+     +============
            |     |         |     |
AZ3         |     o---->----o     |
            |     |         |     |
============+=====+=========+=====+============

Legend:
  o - elastic network interface
  = - AZ boundary
```
