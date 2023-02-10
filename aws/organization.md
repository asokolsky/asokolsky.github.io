# Aws Organization

Org should have:

* logging account - so that no one can edit or delete these.
* programmatic creation of other accounts
* reserved instances
* consolidated billing
* service control policies, eg. set limits on what an account can do.

## Service Control Policies

SCP does not give permission, only takes it away.


## AWS Resource Access Manager

RAM - free service to share resources across accounts in the organization.

Resources can be shared:

* transit gw
* vpc subnets
* License manager
* dedicated hosts
* route53

### Tips

RAM vs VPC peering

Same region? -> RAM, otherwise VPC peering

Sharing resources - saves money

## Cross Account Role Access

Role assumption is always temporary, which is more secure.

Instead of IAM users use roles.

## Inventory Management with AWS Config

Value:

* query - you can discover what you have inside account
* enforce - rules can be created to act
* learn - query history of environment
