# kubectl Cheat Sheet

From

* https://kubernetes.io/docs/reference/kubectl/cheatsheet/
* https://cheat-sheets.nicwortel.nl/kubectl-cheat-sheet.pdf
* https://dockerlabs.collabnix.com/kubernetes/cheatsheets/kubectl.html

[Installation](install.html)

## Configuration File and Environment Variables

By default configuration is in `~/.kube/config`.

[Environment variables](https://kubernetes.io/docs/reference/kubectl/kubectl/#environment-variables).
Most important environment variable:
```
KUBECONFIG=$HOME/.kube/dev-config
```

## Global flags

Flag|Description
----|------
`-A,--all-namespaces`|Use all the namespaces
`-n,--namespace <namespace>`|The name of the namespace to use
`--help`|Show information about a given command

## Context and configuration

Command|Description
----|------
`kubectl config get-contexts`|List all contexts
`kubectl config current-context`|Display the current context
`kubectl config use-context <context>`|Switch to another context
`kubectl config delete-context <context>`|Delete the specified context from the kubeconfig

## Display resources

Command|Description
----|------
`kubectl get <resource>`|List all resources of this type in the current namespace
`kubectl get <resource> -o wide`|List all resources with more details
`kubectl get <resource> -A`|List all resources of this type in all namespaces
`kubectl get <resource> <name>`|List a particular resource
`kubectl get <resource> <name> -o yaml`|Print a particular resource in YAML format
`kubectl get <resource> <name> -l <key1>=<value1>`|List resources where label `<key1>` contains `<value1>`
`kubectl describe <resource>`|Show detailed information about a resource

E.g. to list all pods:
```sh
kubectl get pod \
    -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name \
    --all-namespaces
```
or just pods in one namespace:
```sh
kubectl get pod --namespace <namespace>
```
then
```sh
kubectl describe pod <podname> --namespace <namespace>
```
to get logs:
```sh
kubectl logs <pod>
```
Relevant events:
```sh
kubectl get events --namespace clari-graphql  --sort-by='.metadata.creationTimestamp'
```

## Apply configuration manifests

Command|Description
----|------
`kubectl apply -f <file>`|Apply a manifest from a file
`kubectl apply -f <dir>`|Apply all manifests in a directory
`kubectl apply -k <dir>`|Apply resources from a kustomize directory

Create multiple YAML objects from stdin:
```
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    env:
    - name: SLEEP_DURATION
      value: "1000000"
    args:
    - sleep
    - "${SLEEP_DURATION}"
---
apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep-less
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    env:
    - name: SLEEP_DURATION
      value: "1000"
    args:
    - sleep
    - "${SLEEP_DURATION}"
EOF
```

## Create resources manually

Command|Description
----|------
`kubectl run <name> --image=<image>`|Start a pod
`kubectl create deployment <name> --image=<image>`|Create a deployment
`kubectl expose pod <pod> --port=<port>`|Create a service for an existing pod
`kubectl expose deployment <name> --port=<port>`|Create a service for an existing deployment
`kubectl create ingress <name> --rule=<host/path=svc:port>`|Create an ingress that routes traffic to a service
`kubectl create job <name> --image=<image>`|Create a job
`kubectl create job <name> --from=cronjob/<name>`|Create a job from a cronjob
`kubectl create cronjob <name> --image=<image> --schedule=<schedule>`|Create a cronjob, using a schedule in Cron format
`kubectl create secret generic <name> --from-literal=<key>=<value>`|Create a secret containing `<key>` and `<value>`
`kubectl create secret docker-registry <name> --docker-server=<server> --docker-username=<username> --docker-password=<password>`|Create a secret for a Docker registry

E.g. to get an interactive shell within your cluster:
```sh
kubectl run my-shell --rm -i --tty --image ubuntu -- bash
```

where

* `my-shell` - the name of the Deployment that is created. Your pod name will
be this plus a unique hash or ID at the end.
* `--rm` - when you exit out of your session, this cleans up the Deployment and
Pod.
* `-i/--tty` - the combination of these is what allows us to attach to an
interactive session.
* `--` delimits the end of the `kubectl run` options from the positional arg
`bash`.
* `bash` - overrides the container's CMD. In this case, we want to launch `bash`
as our container's command.

## Generate YAML configuration manifests

Command|Description
----|------
`kubectl create deployment <name> --image=<image> --dry-run=client -o yaml`|Generate a deployment manifest
`kubectl expose deployment <name> --port=<port> --dry-run=client -o yaml`|Generate a service manifest for a deployment

## Edit resources

Command|Description
----|------
`kubectl edit <resource> <name>`|Edit a resource in a text editor
`kubectl set image <resource> <name> <container>=<image>`|Update the image of a container in a pod

## Set labels and annotations
Command|Description
----|------
`kubectl label <resource> <name> <key>=<value>`|Add a label to a resource
`kubectl annotate <resource> <name> <key>=<value>`|Add an annotation to a resource

## Delete resources
Command|Description
----|------
`kubectl delete <resource> <name>`|Delete a particular resource
`kubectl delete <resource> --all`|Delete all resources of a particular type in the current namespace
`kubectl delete -f <file>`|Delete a resource from a file

To delete a pod:
```
kubectl delete pod busybox-sleep-less
```

## Manage deployments
Command|Description
----|------
`kubectl rollout status deployment <name>`|Show the status of a deployment rollout
`kubectl rollout history deployment <name>`|View the rollout history of a deployment
`kubectl rollout undo deployment <name>`|Undo a previous rollout deployment
`kubectl rollout restart deployment <name>`|Restart a deployment
`kubectl scale deployment <name> --replicas=<n>`|Scale a deployment to `<n>` replicas
`kubectl autoscale deployment <name> --min=<min> --max=<max>`|Autoscale a deployment between `<min>` and `<max>` replicas

## Execute commands
Command|Description
----|------
`kubectl exec <pod> -- <command>`|Execute a command in a running pod
`kubectl exec -it <pod> -- sh`|Open a shell in a running pod

## View logs
Command|Description
----|------
`kubectl logs <pod>`|Print the logs for a pod
`kubectl logs -f <pod>`|Print the logs for a pod and keep streaming

## Resource usage
Command|Description
----|------
`kubectl top node`|Show resource (CPU/memory) usage of nodes
`kubectl top pod`|Show resource (CPU/memory) usage of pods

## Other commands
Command|Description
----|------
`kubectl version`|Show the version of the client and server
`kubectl api-resources`|Print the supported API resources on the server

## Helm
Helm is the Kubernetes package manager.
[Installation instructions](https://helm.sh/docs/intro/install/)

Command|Description
----|------
`helm install <name> <chart>`|Install a chart with a name
`helm install <name> <chart> --namespace <namespace>`|Install a chart in a specific namespace
`helm list`|List releases
`helm uninstall <name>`|Uninstall a release
`helm upgrade <name> <chart>`|Upgrade a release
