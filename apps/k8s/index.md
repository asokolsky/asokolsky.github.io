# K8S Topics

* [k8s implementations](k8s-implementations.html)
* kubectl [installation](./kubectl-install.html), [cheat sheet](kubectl.html),
[secrets management](./kubectl-secrets.html),
[managing profiles](./kubectl-manage-profile.html)
* [Playing with a K3S Cluster](./k3s-cluster.html)
* [k9s](k9s.html)

## Pod Troubleshooting

[kubectl debug reference](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_debug/)

Use [kubectl debug](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/#ephemeral-container)
to create an ephemeral container using, e.g. docker image
[aws-cli-v2-on-ubuntu](https://github.com/zulhfreelancer/docker-aws-cli-v2-on-ubuntu):

```
> kubectl debug -it keel-7b5fbd4bcb-mlqbz --namespace=keel --target=mtail \
    --image=zulhfreelancer/aws-cli-v2-on-ubuntu
Targeting container "mtail". If you don't see processes from this container it may be because the container runtime doesn't support this feature.
Defaulting debug container name to debugger-nwff9.
If you don't see a command prompt, try pressing enter.

root@keel-7b5fbd4bcb-mlqbz:/home# env|grep AWS

root@keel-7b5fbd4bcb-mlqbz:/home# aws s3 ls

An error occurred (AccessDenied) when calling the ListBuckets operation: Access Denied

root@keel-7b5fbd4bcb-mlqbz:/home# aws sts get-caller-identity

[Errno 2] No such file or directory: 'less': 'less'

root@keel-7b5fbd4bcb-mlqbz:/home# export AWS_PAGER=""

root@keel-7b5fbd4bcb-mlqbz:/home# aws sts get-caller-identity
{
    "UserId": "12234454545454:i-121212121212",
    "Account": "84232323",
    "Arn": "arn:aws:sts::84232323:assumed-role/Karpenter-test-20231003172341681800000003/i-121212121212"
}
```

Alternatively use [busybox](https://en.wikipedia.org/wiki/BusyBox)
[image](https://hub.docker.com/_/busybox):

```sh
kubectl debug -it keel-7b5fbd4bcb-mlqbz --namespace=keel --target=mtail \
    --image=busybox:1.28
```

Example use of the ephemeral container with a psql client - note the way to
specify a custom container entry point:
```sh
kubectl debug -it keel-58ffc64f8b-f9gk4 --namespace=keel \
    --image=jbergknoff/postgresql-client -- sh
```
