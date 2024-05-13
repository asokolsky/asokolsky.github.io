# Certificates used by an K8S Cluster

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

      --advertise-address=192.36.14.8
      --allow-privileged=true
      --authorization-mode=Node,RBAC
      --client-ca-file=/etc/kubernetes/pki/ca.crt
      --enable-admission-plugins=NodeRestriction
      --enable-bootstrap-token-auth=true
      --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
      --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
      --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
      --etcd-servers=https://127.0.0.1:2379
      --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
      --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
      --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
      --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
      --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
      --requestheader-allowed-names=front-proxy-client
      --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
      --requestheader-extra-headers-prefix=X-Remote-Extra-
      --requestheader-group-headers=X-Remote-Group
      --requestheader-username-headers=X-Remote-User
      --secure-port=6443
      --service-account-issuer=https://kubernetes.default.svc.cluster.local
      --service-account-key-file=/etc/kubernetes/pki/sa.pub
      --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
      --service-cluster-ip-range=10.96.0.0/12
      --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
      --tls-private-key-file=/etc/kubernetes/pki/apiserver.key

     etcd
      --advertise-client-urls=https://192.36.14.8:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --experimental-initial-corrupt-check=true
      --experimental-watch-progress-notify-interval=5s
      --initial-advertise-peer-urls=https://192.36.14.8:2380
      --initial-cluster=controlplane=https://192.36.14.8:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://192.36.14.8:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://192.36.14.8:2380
      --name=controlplane
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt