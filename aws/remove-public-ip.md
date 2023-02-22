# Remove a public IP from an EC2 instance

Before you proceed:

* If the public IP is an elastic IP - easy: do Networking/Disassociate Elastic IP Address.  Done.
* If the EC2 instance belongs to an auto scaling group - just terminating it
will result in a new instance being created.  The latter will NOT have public IP if configured properly.

The rest assumes the public IP is NOT elastic and that even short instance downtime is not acceptable.

Reference: [Amazon EC2 instance IP addressing](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing.html)

## Summary

The described below method involves:

* Creating a new network interface 
* Attaching the newly created interface to the ec2 instance
* Creating a new elastic public IP
* Associating the newly created public IP with the ec2 instance.  This will remove an old public IP from the instance.
* Disassociating the elastic IP from the ec2 instance.  This will leave the ec2 instance with no public IP.
* Deleting the elastic IP created before.

By the end, the instance is left with two network interfaces and no public IP.
If the second network interface is removed, the public IP will come back the next time the instance is restarted.

## 0. Get the instance details

Assumptions:

* aws cli is installed and you are logged in
* the instance subnet is configured to NOT provide public IP by default.

[describe-instances](https://awscli.amazonaws.com/v2/documentation/api/2.0.34/reference/ec2/describe-instances.html)

Inputs:

* EC2 instance id: i-aaaaaa

```sh
aws ec2 describe-instances --instance-ids i-aaaaaaa
```

outputs:

* network-interface-id: eni-oldold
* attachment-id: eni-attach-oldold
* subnetID: subnet-xxx
* security groups: sg-aaaaa, sg-bbbbb

## 1. Create a new network interface

[create-network-interface](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/create-network-interface.html)

inputs:

* subnetID: subnet-xxx
* security groups: sg-aaaaa, sg-bbbbb

```sh
aws ec2 create-network-interface --subnet-id subnet-xxx --groups sg-aaaaa sg-bbbbb
```

outputs:

* NetworkInterfaceId: eni-newnew

verify no public IP is associated

## 2. Attach the network interface to the ec2 instance

[attach-network-interface](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/attach-network-interface.html)

inputs:

* network-interface-id: eni-newnew
* EC2 instance id: i-aaaaaa

```sh
aws ec2 attach-network-interface --network-interface-id eni-aaaaa --instance-id i-aaaa --device-index 1
```

outputs:

* AttachmentId: eni-attach-xxx

## 3. Create a new (public) Elastic IP

[allocate-address](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/allocate-address.html)


Inputs:

* network-border-group

```sh
aws ec2 allocate-address --domain vpc --network-border-group us-west-2
```

outputs:

* allocation-id: eipalloc-aaaa

## 4. Associate the new elastic IP with the old network interface

[associate-address](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/associate-address.html)


Inputs:

* allocation-id: eipalloc-newnew
* network-interface-id: eni-oldold

```sh
aws ec2 associate-address --allocation-id eipalloc-newnew --network-interface-id eni-oldold
```

outputs:

* AssociationId: eipassoc-aaaaa

The original public IP will be replaced by the new one.

## 5. Disassociate the EIP you have just added.

[disassociate-address](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/disassociate-address.html)

Inputs:

* association-id eipassoc-aaaaa

```sh
aws ec2 disassociate-address --association-id eipassoc-aaaaa
```

## 6. Delete the elastic IP you created

[release-address](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/release-address.html)

Inputs:

* allocation-id: eipalloc-aaaaaa

```sh
aws ec2 release-address --allocation-id eipalloc-aaaaa
```

## 7. Attention!

Do not delete the new extra Network Interface!

This has to stay in place.
If you remove the new/second NI then the public IP will come back the next time you stop and start the instance.
