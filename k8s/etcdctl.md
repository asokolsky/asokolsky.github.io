# etcdctl

```sh
export ETCDCTL_API=3
```

## Take a snapshot

[Backing up an etcd cluster](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster)

```sh
etcdctl snapshot save -h
```
and keep a note of the mandatory global options.

Since our ETCD database is TLS-Enabled, the following options are mandatory:

* --cacert - verify certificates of TLS-enabled secure servers using this CA bundle
* --cert - identify secure client using this TLS certificate file
* --endpoints=[127.0.0.1:2379] - the default, as ETCD is running on master node
and exposed on localhost 2379.
* --key - identify secure client using this TLS key file

## Restore from a snapshot

[Restoring an etcd cluster](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#restoring-an-etcd-cluster)

Similarly use the help option for snapshot restore to see all available options
for restoring the backup.

```sh
etcdctl snapshot restore -h
```

Pay attention to the command line:

```
     --advertise-client-urls=https://192.0.78.3:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --experimental-initial-corrupt-check=true
      --experimental-watch-progress-notify-interval=5s
      --initial-advertise-peer-urls=https://192.0.78.3:2380
      --initial-cluster=controlplane=https://192.0.78.3:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://192.0.78.3:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://192.0.78.3:2380
      --name=controlplane
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
```

## Identifying the etcd Cluster Members

```sh
export ETCDCTL_API=3
etcdctl member list \
  --endpoints=https://127.0.0.1:2379
  --cacert=/etc/etcd/pki/ca.pem
  --cert=/etc/etcd/pki/etcd.pem
  --key=/etc/etcd/pki/etcd-key.pem
```
