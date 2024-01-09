# Working with MicroK8s

## Install

```
alex@exi  ~  sudo snap install microk8s --classic --channel=1.29/stable
[sudo] password for alex:
microk8s (1.29/stable) v1.29.0 from Canonical✓ installed
```
Verify:
```
alex@exi  ~  sudo microk8s version
MicroK8s v1.29.0 revision 6364
```

Disable `ha-cluster`:
```
alex@exi  ~  microk8s disable ha-cluster --force
Infer repository core for addon ha-cluster
Reverting to a non-HA setup
Enabling flanneld and etcd
HA disabled
```
