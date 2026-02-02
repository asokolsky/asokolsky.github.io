# k8s Nodes

## Count cluster nodes:

```sh
kubectl get nodes --no-headers | wc -l
```
or
```sh
kubectl get nodes -o json | jq '.items | length'
```

## List taints for all the nodes

```sh
kubectl get nodes -o json|jq '.items[].spec.taints'
```
Example output:

```json
[
  {
    "effect": "NoSchedule",
    "key": "eks.amazonaws.com/compute-type",
    "value": "fargate"
  }
]
[
  {
    "effect": "NoSchedule",
    "value": "eks-core-services"
  }
]
null
```

Alternatively:
```sh
kubectl get nodes -o="custom-columns=NodeName:.metadata.name,TaintKey:.spec.taints[*].key,TaintValue:.spec.taints[*].value,TaintEffect:.spec.taints[*].effect"
```
Output:
```
NodeName                               TaintKey                         TaintValue          TaintEffect
fargate-ip-10-14-81-126.ec2.internal   eks.amazonaws.com/compute-type   fargate             NoSchedule
ip-10-14-103-86.ec2.internal           <none>                           <none>              <none>
ip-10-14-86-93.ec2.internal            <none>                           <none>              <none>
ip-10-14-94-45.ec2.internal            <none>                           <none>              <none>
ip-10-14-99-93.ec2.internal            <none>                           <none>              <none>
```

## List info for all the nodes:

```sh
kubectl get nodes -o json|jq '.items[].status.nodeInfo'
```

Example output:

```json
{
  "architecture": "amd64",
  "bootID": "**************",
  "containerRuntimeVersion": "containerd://1.6.6",
  "kernelVersion": "5.10.210-201.855.amzn2.x86_64",
  "kubeProxyVersion": "v1.27.9-eks-680e576",
  "kubeletVersion": "v1.27.9-eks-680e576",
  "machineID": "",
  "operatingSystem": "linux",
  "osImage": "Amazon Linux 2",
  "systemUUID": "******************"
}
{
  "architecture": "amd64",
  "bootID": "****************************",
  "containerRuntimeVersion": "containerd://1.6.31+bottlerocket",
  "kernelVersion": "5.15.152",
  "kubeProxyVersion": "v1.27.11-eks-9572756",
  "kubeletVersion": "v1.27.11-eks-9572756",
  "machineID": "*******************",
  "operatingSystem": "linux",
  "osImage": "Bottlerocket OS 1.19.4 (aws-k8s-1.27)",
  "systemUUID": "***********************"
}
```

## Taint/UnTaint a node

To taint the `node1` with `key1=value1`:
```sh
kubectl taint nodes node1 key1=value1:NoSchedule
```
No pod will be able to schedule onto `node1` unless it has a matching
toleration.

To remove the taint added by the command above, you can run:

```sh
kubectl taint nodes node1 key1=value1:NoSchedule-
```
## Label a node

```sh
kubectl label node node01 color=blue
```

## Node affinity

## Drain the node

```sh
kubectl drain --ignore-daemonsets node01
```

# Bring the node back online

```sh
kubectl uncordon node01
```
