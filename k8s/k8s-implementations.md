# Some Lightweight K8s Implementations

Feature|Minikube|K3S/K3D|MicroK8s|KinD|K0S
-------|--------|-------|--------|----|---
Author|Kubernetes|Rancher|Canonical|Kubernetes|Mirantis
Home|[minikube.sigs.k8s.io](https://minikube.sigs.k8s.io/docs/)|[k3s.io](https://k3s.io/) [k3d.io](https://k3d.io/)|[microk8s.io](https://microk8s.io/)|[kind.sigs.k8s.io](https://kind.sigs.k8s.io/)|[k0sproject.io](https://docs.k0sproject.io/v1.28.2+k0s.0/)
Repo|[kubernetes/minikube](https://github.com/kubernetes/minikube)|[k3s-io/k3s](https://github.com/k3s-io/k3s) [k3d-io/k3d](https://github.com/k3d-io/k3d)|[ubuntu/microk8s](https://github.com/ubuntu/microk8s)|[kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)|[k0sproject/k0s](https://github.com/k0sproject/k0s)
Suitability|Testing|Testing, Production, IoT|IoT|CI
CNCF-Certified|Yes|Yes|Yes|Yes|Yes
1-node cluster|Yes|Yes|Yes|Yes|Yes
multi-node cluster|Yes|Yes|Yes|Yes|Yes
Architecture|x86 arm64 ARMv7 ppc64 s390x|x86_64 armhf arm64 aarch64 s390x|x86 arm64 s390x POWER9|amd64 arm64|x866-64 arm64 ARMv7
Min CPU|2+|1+|1+|?|1+
Min RAM|2GB|512MB|540MB|?|1GB
Container RT|Docker, containerd, CRI-O|Docker, containerd|containerd, kata|Docker, CRI-O|containerd
Networking|Calico, Cilium, Flannel, ingress, DNS, Kindnet|Canal, CoreDNS, Flannel, Traefik, Klipper|Calico, Cilium, CoreDNS, Traefik, nginx, Ambassador, Multus, MetalLB|kindnetd|Calico, kube-router
OS|Linux, macOS, Windows|Linux|Linux|Linux, macOS, Windows|Linux, Windows Server 2019


## Conclusion

From
[this comparison](https://alperenbayramoglu2.medium.com/simple-comparison-of-lightweight-k8s-implementations-7c07c4e6e95f):


* Minikube is the easiest to use but it is not suitable for production.
* For performance-constraint environments, K3S is an easy to use lightweight
K8s implementation.
* MicroK8s offers more features in terms of usage but it is more difficult to
configure and install than others, could be a good duo with the Ubuntu.
* In resource-constrained environments, it is useful to consider also K0S.
* K0S and K3S are similar though if a proper toolchain is in place K0S pays
attention to security by providing 100% FIPS compliance.
