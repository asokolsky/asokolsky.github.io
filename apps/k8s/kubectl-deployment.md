# k8s Deployments

## Create an Ad-Hoc Deployment

Use
[kubectl_create_deployment](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_deployment/):

```sh
kubectl create deployment --image=nginx nginx
```

To generate a deployment YAML file:
```sh
kubectl create deployment nginx --image=nginx nginx --replicas=4 \
    --dry-run=client -o yaml > nginx-deployment.yaml
```

## Affinity

https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-04-29T16:33:03Z"
  generation: 1
  labels:
    app: blue
  name: blue
  namespace: default
  resourceVersion: "1668"
  uid: 0e218576-1f9a-4b22-8b06-49b11793ff0d
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: blue
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - nodeSelectorTerms:
              matchExpressions:
              - key: color
                operator: In
                values:
                  - blue
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
```
