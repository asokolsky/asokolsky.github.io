# Kubernetes Concepts

![k8s cluster](https://kubernetes.io/images/docs/components-of-kubernetes.svg)

k8s runs workload by placing containers into Pods to run on Nodes.
Each node is managed by the control plane and contains the services necessary
to run Pods.

[Control Plane Components](https://kubernetes.io/docs/concepts/overview/components/#control-plane-components)

## Node

There are master and worker nodes

[Node components](https://kubernetes.io/docs/concepts/overview/components/#node-components):

* the kubelet - an agent that runs on each node in the cluster, makes sure that
containers are running in a Pod.
* a container runtime, responsible for managing the execution and lifecycle of
containers
* the kube-proxy, a network proxy that runs on each node in your cluster,
implementing part of the Kubernetes Service concept.

Master node has:

* etcd
* kube controller manager
* kube-scheduler
* kube-apiserver

About [node ops](kubectl-nodes.html).

To manage association of pods to nodes, we assign a
[taint](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
to a node and [toleration](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
to a pod.

### List node taints

To list node taints:
```sh
kubectl get nodes -o json|jq '.items[].spec.taints'
```

### Taint a node

To taint the `node1` with `key1=value1`:
```sh
kubectl taint nodes node1 key1=value1:NoSchedule
```
No pod will be able to schedule onto `node1` unless it has a matching
toleration.

### Remove the node taint

To remove the taint added by the command above, you can run:

```sh
kubectl taint nodes node1 key1=value1:NoSchedule-
```

## Pod

A [pod](https://kubernetes.io/docs/concepts/workloads/pods/) is the smallest
deployable unit, a wrapper around one or more containers.

You specify a toleration for a pod in the PodSpec. Both of the following
tolerations "match" the taint created by the kubectl taint line above, and thus
a pod with either toleration would be able to schedule onto node1:

```yaml
tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"
```

```yaml
tolerations:
- key: "key1"
  operator: "Exists"
  effect: "NoSchedule"
```

## Addons

[Addons](https://kubernetes.io/docs/concepts/overview/components/#addons) use
resources (DaemonSet, Deployment, etc) to implement cluster features.
Namespaced resources for addons belong within the `kube-system` namespace.
Include:

* [cluster DNS](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
* [dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
* [container resource monitoring](https://kubernetes.io/docs/tasks/debug/debug-cluster/resource-usage-monitoring/)
* [cluster level logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/)
* [network plugins](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/)

## Deployment

Deployment is a Kubernetes controller that matches the current state of your
cluster to the desired state mentioned in the Deployment manifest.

Deployment creates a ReplicaSet which, in turn, creates pod(s).

## StatefulSet

[StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)
is manages stateful applications. It manages the deployment and scaling of a
set of Pods, and provides guarantee about the ordering and uniqueness of these
Pods.

StatefulSet is also a Controller but unlike Deployment, it doesn’t create
ReplicaSet rather itself creates the Pod with a unique naming convention.

## DaemonSet

A DaemonSet is a controller that ensures that the pod runs on all the nodes of
the cluster.

## Comparisons

[deployments-vs-statefulsets-vs-daemonsets](https://medium.com/stakater/k8s-deployments-vs-statefulsets-vs-daemonsets-60582f0c62d4)

## crictl

[crictl](https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/) is a
[container runtime cli](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md).
See also [containerd](/apps/docker/containerd.html).

## etcd

cli: [etcdctl](etcdctl.html)

## kube-apiserver

does:

* user authentication
* request validation
* data retrieval (from etcd)
* etcd update
* talking to scheduler
* talking to kubelet

kube-apiserver is the only entity talking to `etcd`

## kube controller manager

Controller monitors state of some object(s)

kube controller manager uses kube-apiserver to monitor node status:

* node monitor period - 5sec
* node monitor grace period - 40sec
* pod eviction timeout - 5min


## kube-scheduler

Decides which pod goes to which node.  Actual deployment is done by a kubelet.

Decision making process:

* filter nodes that do not need requested resorues
* rank nodes

Relevant attributes:

* resource requirements and limits
* taints and tolerations
* node selector/affinity

## kubelet

* registers the node with the cluster
* creates pods
* monitors pod state

Note: kubeadm does NOT deploy kubelets.

## kube-proxy

kube-proxy:

* runs on each node,
* allows for the pods across the nodes to talk to each other

## YAML manifests

Always have:

* apiVersion
* kind
* metadata
* spec
