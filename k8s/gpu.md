# Use of (NVIDIA) GPUs in k8s

[Solution](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/) involves:

* [device plugin](https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/#using-device-plugins), e.g. [NVIDIA](https://github.com/NVIDIA/k8s-device-plugin#quick-start)
* use of node labels and node selectors to pick the node with the right GPU
* [Node Feature Discovery](https://github.com/kubernetes-sigs/node-feature-discovery)

NVIDIA stack includes (high to low abstraction level):

* [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin) with [gpu-feature-discovery](https://github.com/NVIDIA/k8s-device-plugin/blob/main/docs/gpu-feature-discovery/README.md)
* [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) which includes NVIDIA Container Runtime.
* [CUDA toolkit](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
* [NVIDIA GPU drivers](https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html)

NVIDIA Container Runtime can use either of:

* [containerd for use with k8s](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-containerd-for-kubernetes)
* [alternatively use](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-cri-o) [CRI-O](https://cri-o.io/)
* [use podman](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-cri-o) with [Container Device Interface](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html)

[Architecture](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/arch-overview.html)
