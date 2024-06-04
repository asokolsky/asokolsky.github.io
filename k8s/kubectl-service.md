# kubectl Service

[kubectl create service](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_service/)

```sh
kubectl create service nodeport service-name --dry-run=client \
    --node-port=30800 -o=yaml --tcp=80:80 > service-service-name.yaml
```

```sh
kubectl create service clusterip redis-service --dry-run=client \
    -o=yaml --tcp=6379:6379 > redis-service.yaml
```
