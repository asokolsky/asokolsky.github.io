# Using REST to do k8s

https://kubernetes.io/docs/reference/using-api/api-concepts/

https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/

## Examples

get api groups:
```
> curl https://kube-master:6443/
{
    "paths":[
        "/api",
        "/api/v1",
        "/apis",
        "/healthz",
        "/logs",
        ...
    ]
}
```
And then within a group show resource groups:
```
> curl https://kube-master:6443/apis -k | grep name
  "name": "extensions",
  "name": "apps",
  ....
```

get version
```
> curl https://kube-master:6443/version
{
    "major":"1",
    "minor":"13",
    "gitVersion":"v1.13.0",
    ...
}
```

## Core Functionality

get pods:
```
curl https://kube-master:6443/api/v1/pods
{
    "kind":"PodList",
    "apiVersion":"v1",
    ...
}
```

## Use kubectl API proxy to provide authentication

To use credentials from `~/.kube/config`:
```
> kubectl proxy
Starting to server on 127.0.0.1:8001
```

##

```sh
kubectl api-resources --namespaced=false
```
