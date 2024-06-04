# Certificates used by a K8s Cluster

From [kubernetes-certs-checker.xlsx](https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/tools/kubernetes-certs-checker.xlsx):

Component|Cert Type|Cert Path|CN Name
---------|---------|---------|--------
CA|Server|/etc/kubernetes/pki/ca.(crt/key)|kubernetes
kube-apiserver|Server|/etc/kubernetes/pki/apiserver.(crt/key)|kube-apiserver
kube-apiserver|Server|/etc/kubernetes/pki/ca.crt|kubernetes
kube-apiserver|Client (kubelet)|/etc/kubernetes/pki/apiserver-kubelet-client.(crt/key)|kube-apiserver-kubelet-client
kube-apiserver|Client (etcd)|/etc/kubernetes/pki/apiserver-etcd-client.(crt/key)|kube-apiserver-etcd-client
kube-apiserver|Client (etcd)|/etc/kubernetes/pki/etcd/ca.crt|kubernetes
kubelet|Server|/var/lib/kubelet/pki/kubelet.(crt/key)|node01@1557660157
kubelet|Client|/var/lib/kubelet/pki/kubelet-client-2019-05-12-11-22-38.pem|system:node:node01
CA (etcd)|Server|/etc/kubernetes/pki/etcd/ca.(crt/key)|kubernetes
etcd-server|Server|/etc/kubernetes/pki/etcd/server.(crt/key)|controlplane

To view the cert:

```sh
openssl x509 -in file-path.crt -text -noout
```
