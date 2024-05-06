# k8s Pods

## Listing pods

Short but [show labels](https://kubebyexample.com/concept/labels):
```sh
kubectl get pods -A --show-labels --watch
```
or

```sh
kubectl get pods -n all -o=wide
```

To count the pods with a specific label:
```sh
kubectl get pods  --show-labels --no-headers --selector env=dev | wc -l
```

Describe all the pods:
```sh
kubectl describe pods -n all
```

## Save pod yaml

```sh
kubectl get pod rabbit -o=yaml
```

## Replace a pod

```sh
kubectl replace --force -f rabbit.yaml
```

## Create an ad-hoc pod

Use
[kubectl run](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_run/)

```sh
kubectl run nginx --image=nginx --port=5701
```

To generate the POD Manifest YAML file:
```
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml
```

Then `cat pod.yaml` gives:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```
You can specify command line in-place:
```sh
kubectl run busybox --image=busybox --command -- sleep 1000
```

To get an interactive shell within your cluster with an AWS CLI client:
```sh
kubectl run ad-hoc --rm -i --tty --image=zulhfreelancer/aws-cli-v2-on-ubuntu -- bash
```

where:

* `ad-hoc` - the name of the pod that to create. Namespace is `default`.
* `--rm` - when you exit out of your session, this cleans up the newly created
pod.
* `-i/--tty` - the combination of these is what allows us to attach to an
interactive session.
* `--` delimits the end of the `kubectl run` options from the positional arg
`bash`.
* `bash` - overrides the container's CMD. In this case, we want to launch `bash`
as our container's command.

To modify limits and/or specify taints use `--overrides` :

```sh
kubectl run ad-hoc --rm -i --tty --image=zulhfreelancer/aws-cli-v2-on-ubuntu --overrides='
{
    "apiVersion":"v1",
    "kind": "Pod",
    "spec": {
        "containers": [
            {
                "name": "ad-hoc",
                "stdin": true,
                "stdinOnce": true,
                "tty": true,
                "image": "zulhfreelancer/aws-cli-v2-on-ubuntu",
                "resources": {
                    "requests":{
                        "cpu": "8000m",
                        "memory": "512Mi"
                    }}}]}}'
```

Note: The above uses
[quantity notation](https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/quantity/),
[resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes).
Hence:

* 8000m cores or 2000 millicores is equal to 8 cores;
* 512Mi bytes is equal to 512
[mebibytes](https://simple.wikipedia.org/wiki/Mebibyte)

Setting cpu to 8 cores may force autoscaler (e.g. karpenter) to allocate a new
cluster node.


## Tolerations

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

## Delete Pod

```sh
kubectl delete pod rabbit
```
The above does not work for static pods
