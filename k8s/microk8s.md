# Working with MicroK8s

## Install MicroK8s

[getting started](https://microk8s.io/docs/getting-started)

```
> sudo snap install microk8s --classic --channel=1.29/stable
[sudo] password for alex:
microk8s (1.29/stable) v1.29.0 from Canonical✓ installed
```
Verify:
```
> sudo microk8s version
MicroK8s v1.29.0 revision 6364
```

Disable `ha-cluster`:
```
> microk8s disable ha-cluster --force
Infer repository core for addon ha-cluster
Reverting to a non-HA setup
Enabling flanneld and etcd
HA disabled
```

[prometheus](https://microk8s.io/docs/external-lma#prometheus-11) is deprecated
use obeservability instead:
```sh
microk8s enable observability
```
Maybe, [install CSI driver for NFS](https://microk8s.io/docs/how-to-nfs#install-the-csi-driver-for-nfs-2).

[Enable ingress](https://microk8s.io/docs/addon-ingress):
```sh
microk8s enable ingress
```

[Services and ports](https://microk8s.io/docs/services-and-ports)

[Install velero](https://microk8s.io/docs/velero) which relies on MinIO.

Use
* https://microk8s.io/docs/working-with-kubectl
* [k9s](k9s.html) and
* https://microk8s.io/docs/troubleshooting

Use [alternatives to Dockerhub](https://microk8s.io/docs/dockerhub-limits)

## Installing MinIO

From:

* https://github.com/minio/minio/tree/master/helm/minio
* https://github.com/minio/operator/tree/master/helm/operator

First:
```sh
sudo microk8s helm3 repo add minio https://operator.min.io/
```
Then:
```
> sudo microk8s helm3 install \
  --namespace minio-operator \
  --create-namespace \
  minio-operator minio/operator
NAME: minio-operator
LAST DEPLOYED: Wed Jan  3 17:28:06 2024
NAMESPACE: minio-operator
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the JWT for logging in to the console:
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: console-sa-secret
  namespace: minio-operator
  annotations:
    kubernetes.io/service-account.name: console-sa
type: kubernetes.io/service-account-token
EOF
kubectl -n minio-operator  get secret console-sa-secret -o jsonpath="{.data.token}" | base64 --decode

2. Get the Operator Console URL by running these commands:
  kubectl --namespace minio-operator port-forward svc/console 9090:9090
  echo "Visit the Operator Console at http://127.0.0.1:9090"
```

## Deploy MQTT

Alternatives:

* [use](https://microk8s.io/docs/addon-shifu)
[shifu](https://github.com/Edgenesis/shifu).
* back to mosquito
https://discuss.kubernetes.io/t/exposing-mqtt-broker/10222
https://blogs.oracle.com/developers/post/install-and-run-mosquitto-on-a-kubernetes-cluster
