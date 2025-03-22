# k8s Pods

## Pod Lifecycle

The primary phases/states in the pod lifecycle are:

* Pending: the pod is accepted by the Kubernetes system but is waiting for resources to be allocated.
* Running: the pod has been scheduled, and all containers are in a running state.
* Succeeded: all the containers in the pod have exited successfully.
* Failed: all containers in the pod have terminated, with at least one container failing.
* CrashLoopBackOff: one or more containers in the pod are repeatedly crashing.

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
    envFrom:
    - secretRef:
        name: test-secret
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

### Create an ad-hoc pod with custom limits

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

### Create an ad-hoc pod in the context of a specific service account

To perform AWS troubleshooting in the context of the service account `foo`
created in the namespace `foo`:
```sh
kubectl run ad-hoc --rm -ti --restart=Never -n foo  \
  --image=zulhfreelancer/aws-cli-v2-on-ubuntu \
  --overrides='{"spec":{"serviceAccount":"foo"}}'
```

### Create an ad-hoc pod on a specific node

To run the pod on the node `node01`:
```sh
kubectl run ad-hoc --rm -ti --restart=Never \
  --image=zulhfreelancer/aws-cli-v2-on-ubuntu \
  --overrides='{"spec":{"nodeName":"node01"}}'
```

Alternatively, to run the pod on the node of specific architecture, e.g.
`amd64`:

```sh
kubectl run ad-hoc --rm -ti --restart=Never \
  --image=zulhfreelancer/aws-cli-v2-on-ubuntu \
  --overrides='{"apiVersion":"v1","spec":{"nodeSelector":{"kubernetes.io/arch":"amd64"}}}'
```



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
Use `--force` if you are impatient.  The above does not work for static pods.


## Static Pods

[Static pods](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/)
are defined in `/etc/kubernetes/manifests`.

## Security Context for a Pod or Container

https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

For a pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  volumes:
  - name: sec-ctx-vol
    emptyDir: {}
  containers:
  - name: sec-ctx-demo
    image: busybox:1.28
    command: [ "sh", "-c", "sleep 1h" ]
    volumeMounts:
    - name: sec-ctx-vol
      mountPath: /data/demo
    securityContext:
      allowPrivilegeEscalation: false
```

For a container:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-2
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: sec-ctx-demo-2
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      runAsUser: 2000
      allowPrivilegeEscalation: false

```

Further to add capabilities:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]

```

To add
[capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)
to the container:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]

```

## Use of Labels

Labels are used, e.g. to link replica sets or services to pods:

1. we label the pod
2. use the same label in the podSelector field in the NetworkPolicy object

## Volume Claim in a Pod

Create a [persistent volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes).

Then use [claims as volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#claims-as-volumes):
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim
```
The same is true for ReplicaSets or Deployments.

## Run a Command in a Container

To run a command in a container use [kubectl exec](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_exec/):

```sh
k exec sleeper -- whoami
```

## Pod Resource Requests and Limits

* Resource requests: specify the minimum CPU and memory that a pod requires.
* Resource limits: define the maximum resources a pod can consume.

Example of setting both CPU and memory requests and limits for a pod:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-limits-pod
spec:
  containers:
  - name: main-app
    image: nginx
    resources:
      requests:
        memory: "128Mi"
        cpu: "250m"
      limits:
        memory: "256Mi"
        cpu: "500m"
```

## Pod Affinity and Anti-Affinity

Affinity rules attract pods to specific nodes or zones. Anti-affinity rules prevent certain pods from being placed together.

Types of Affinity:

* Node Affinity: controls which nodes a pod can be scheduled on based on node labels.
* Inter-Pod Affinity: Ensures that certain pods are scheduled near each other.
* Inter-Pod Anti-Affinity: Prevents certain pods from being scheduled on the same node or zone to improve resilience.

Example of a pod with node affinity for better performance:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: affinity-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: "zone"
            operator: In
            values:
            - "us-west-1a"
  containers:
  - name: main-app
    image: nginx
```

This pod will only be scheduled on nodes within the specified zone (`us-west-1a`), ensuring optimal location for workload needs.

## Pod Disruption Budget (PDB)

A PDB defines the minimum number of pods that must be available during planned disruptions, such as updates or maintenance, ensuring application uptime.

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: my-app-pdb
spec:
  minAvailable: 1
  selector:
    matchLabels:
      app: my-app
```
This ensures at least one pod labeled `app: my-app` remains available even during disruptions.
