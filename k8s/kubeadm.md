# kubeadm

## Upgrading the cluster

### Create a plan

```
controlplane ~ ✖ kubeadm upgrade plan
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.28.0
[upgrade/versions] kubeadm version: v1.28.0
I0508 17:19:37.833235   15100 version.go:256] remote version is much newer: v1.30.0; falling back to: stable-1.28
[upgrade/versions] Target version: v1.28.9
[upgrade/versions] Latest version in the v1.28 series: v1.28.9

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       TARGET
kubelet     2 x v1.28.0   v1.28.9

Upgrade to the latest version in the v1.28 series:

COMPONENT                 CURRENT   TARGET
kube-apiserver            v1.28.0   v1.28.9
kube-controller-manager   v1.28.0   v1.28.9
kube-scheduler            v1.28.0   v1.28.9
kube-proxy                v1.28.0   v1.28.9
CoreDNS                   v1.10.1   v1.10.1
etcd                      3.5.9-0   3.5.9-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.28.9

Note: Before you can perform this upgrade, you have to update kubeadm to v1.28.9.

_____________________________________________________________________


The table below shows the current state of component configs as understood by this version of kubeadm.
Configs that have a "yes" mark in the "MANUAL UPGRADE REQUIRED" column require manual config upgrade or
resetting to kubeadm defaults before a successful upgrade can be performed. The version to manually
upgrade to is denoted in the "PREFERRED VERSION" column.

API GROUP                 CURRENT VERSION   PREFERRED VERSION   MANUAL UPGRADE REQUIRED
kubeproxy.config.k8s.io   v1alpha1          v1alpha1            no
kubelet.config.k8s.io     v1beta1           v1beta1             no
_____________________________________________________________________
```

Drain the `controlplane` node:
```sh
k drain controlplane  --ignore-daemonsets
```

### Upgrade the control plane

[Upgrade the control plane node](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/#upgrading-control-plane-nodes):

* the kubeadm tool (if not already), then
* the controlplane components, and finally
* the kubelet.

Upgrade kubeadm:
```sh
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.29.0-*' && \
sudo apt-mark hold kubeadm
```

```sh
kubeadm upgrade apply v1.29.0
```

Upgrade kubelet and kubectl, replace x in 1.30.x-* with the latest patch:
```sh
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.29.0-*' kubectl='1.29.0-*' && \
sudo apt-mark hold kubelet kubectl
```

Restart the kubelet:
```sh
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

### Upgrade the workers

https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/#upgrading-worker-nodes

Upgrade kubeadm, replace x in 1.30.x-* with the latest patch version:

```sh
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.28.9-*' && \
sudo apt-mark hold kubeadm
```

For worker nodes this upgrades the local kubelet configuration:
```sh
sudo kubeadm upgrade node
```

Drain the node from a control plane node:

```sh
kubectl drain node01 --ignore-daemonsets
```

Upgrade kubelet and kubectl, replace x in 1.30.x-* with the latest patch version:

```sh
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.28.9-*' kubectl='1.28.9-*' && \
sudo apt-mark hold kubelet kubectl
```
Restart the kubelet:
```sh
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

Uncordon the node, execute this command on a control plane node:

```sh
kubectl uncordon node01
```