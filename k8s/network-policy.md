# Network Policy

[Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

Network policy should be supported by implementation. It is supported in:

* kube-router
* calico
* romana
* weave-net

Not supported (not enforced, will not error) in:

* flannel

## Listing

```sh
k get networkpolicy
```
