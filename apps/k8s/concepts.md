# k8s concepts


## Nodes

Nodes can have a
[taint](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/):

```sh
kubectl taint nodes node1 key1=value1:NoSchedule
```
No pod will be able to schedule onto node1 unless it has a matching toleration.

To remove the taint added by the command above, you can run:

```sh
kubectl taint nodes node1 key1=value1:NoSchedule-
```

## Pods

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
