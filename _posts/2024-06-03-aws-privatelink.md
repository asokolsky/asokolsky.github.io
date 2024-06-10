---
title: Build AWS Privatelink in Terraform
tags: aws
---

Usage scenario: expose custom (non-AWS) services provided in one VPC to
consumers in another VPC.

## Terminology and Architecture

Rehash of
[privatelink](https://docs.aws.amazon.com/vpc/latest/privatelink/privatelink-share-your-services.html)
definitions:

```
+-------------------------------------+
|                                     |
|  Service Consumer VPC               |
|                                     |
|    VPC endpoint ENI                 |
+-----o-------------------------------+
      |
     \|/
+-----o-------------------------------+
|    VPC Endpoint Service             |
|     |                               |
|    \|/                              |
|    NLB                              |
|     |                               |
|    \|/                              |
|    ALB                              |
|                                     |
|  Service Provider VPC               |
|                                     |
+-------------------------------------+
```

[Read on architecture](https://www.taccoform.com/posts/aws_pvt_link_1/)

## Terraform

[Read on terraform](https://www.taccoform.com/posts/aws_pvt_link_2/)

## See Also

[ALB behind an NLB Gotchas](/2024/05/04/alb-behind-nlb.html)
