# Accessing k8s app logs

```sh
kubectl logs <pod>
```

To access all the `karpenter` pod logs:
```sh
for pod_name in $(kubectl get pods -n karpenter -o jsonpath='{.items[*].metadata.name}'); do
    echo "--- Logs for pod: $pod_name ---"
    kubectl logs $pod_name -n karpenter --all-containers=true --timestamps
    echo ""
done
```

But the above sucks.  Better use [stern](https://github.com/stern/stern):
```sh
stern -n karpenter -i InsufficientInstanceCapacity karpenter
```
