# Playing with a K3S Cluster

## Hardware & OS

Installed Ubuntu server 22.04 on
[3x Optiplex7060](/hardware/optiplex7060micro.md):

* `minimum` config - even `nano` not available, yet `htop` is there!
* installed on `sda`, NVME disk left for later use...

[Hosts](../hardware/optiplex7060micro.md):

Host|IP
----|-
LB|192.168.10.16
g4tzrz2|192.168.10.17
g50zrz2|192.168.10.18
j01ydx2|192.168.10.19

where LB IP is

## OS Customization

Should have done this later in ansible.  But still:

Install packages:
```sh
sudo apt install ethtool emacs-nox htop lm-sensors nvme-cli cpufrequtils sysstat
```

### Delay at Grub Splash

I see a 10s delay on grub splash, yet `/etc/default/grub` has `GRUB_TIMEOUT=0`.
I set it to 1, then `sudo update-grub2`.  That did the job.

### 10s+ Boot Delay at "Wait for Network to be Configured"

I guess this is may be cause by a second NIC which is not connected.
Edit `/etc/netplan/00-installer-config.yaml`:

```yaml
# This is the network config written by 'subiquity'
network:
  ethernets:
    eno1:
      dhcp4: true
    enp1s0:
      dhcp4: true
      optional: true
  version: 2
```
I added `optional: true` to the 2nd NIC.  That did the job.


## Install K3S on to the cluster

Cloned [k3s-ansible](https://github.com/techno-tim/k3s-ansible).
[Walk-through](https://www.youtube.com/watch?v=S_pp_nc5QuI).

1. Edit `ansigble.cfg`:
```
[defaults]
inventory = inventory/my-cluster/hosts.ini

[privilege_escalation]
become = True
```

2. Edit `hosts.ini`:
```
[master]
192.168.10.17
192.168.10.18
192.168.10.19

[node]
```

3. Edit `inventory/my-cluster/group_vars/all.yaml`


Then
```sh
ansible-playbook site.yml --ask-become-pass
```

After the install a LB is available - `192.168.10.16` is bound by `g4tzrz2`:
```
alex@latitude7490:~/Projects/lan960/ > ansible cluster -m command -a "ip address show eno1"
g4tzrz2 | CHANGED | rc=0 >>
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether e4:54:e8:6e:d8:f6 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
    inet 192.168.10.17/24 metric 100 brd 192.168.10.255 scope global dynamic eno1
       valid_lft 6359sec preferred_lft 6359sec
    inet 192.168.10.16/32 scope global eno1
       valid_lft forever preferred_lft forever
    inet6 fe80::e654:e8ff:fe6e:d8f6/64 scope link
       valid_lft forever preferred_lft forever
g50zrz2 | CHANGED | rc=0 >>
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether e4:54:e8:6e:bd:ef brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
    inet 192.168.10.18/24 metric 100 brd 192.168.10.255 scope global dynamic eno1
       valid_lft 6532sec preferred_lft 6532sec
    inet6 fe80::e654:e8ff:fe6e:bdef/64 scope link
       valid_lft forever preferred_lft forever
j01ydx2 | CHANGED | rc=0 >>
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 6c:2b:59:f8:0d:f6 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
    inet 192.168.10.19/24 metric 100 brd 192.168.10.255 scope global dynamic eno1
       valid_lft 6665sec preferred_lft 6665sec
    inet6 fe80::6e2b:59ff:fef8:df6/64 scope link
       valid_lft forever preferred_lft forever
```

## Install kubectl & helm on laptop

* Followed
[instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
to install `kubectl` on a laptop;
* created `~/.kube/config` by copying `/root/.kube/config` from the cluster
node.

Then:
```
alex@latitude7490:~/ > kubectl get nodes -o wide
NAME      STATUS   ROLES                       AGE   VERSION        INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
g4tzrz2   Ready    control-plane,etcd,master   16h   v1.25.9+k3s1   192.168.10.17   <none>        Ubuntu 22.04.2 LTS   5.15.0-76-generic   containerd://1.6.19-k3s1
g50zrz2   Ready    control-plane,etcd,master   16h   v1.25.9+k3s1   192.168.10.18   <none>        Ubuntu 22.04.2 LTS   5.15.0-76-generic   containerd://1.6.19-k3s1
j01ydx2   Ready    control-plane,etcd,master   16h   v1.25.9+k3s1   192.168.10.19   <none>        Ubuntu 22.04.2 LTS   5.15.0-76-generic   containerd://1.6.19-k3s1
```

Followed
[instructions](https://helm.sh/docs/intro/install/#from-apt-debianubuntu)
and installed `helm`.

## Test nginx Deploy

Deploy the sample:
```
alex@latitude7490:~/Projects/k3s-ansible/example/ > kubectl apply -f deployment.yml
deployment.apps/nginx created
alex@latitude7490:~/Projects/k3s-ansible/example/ > kubectl apply -f service.yml
service/nginx created
```

Query cluster:
```
alex@latitude7490:~/ > kubectl get deploy -o wide
NAME    READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS   IMAGES         SELECTOR
nginx   3/3     3            3           7m34s   nginx        nginx:alpine   app=nginx
alex@latitude7490:~/ > kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE    IP           NODE      NOMINATED NODE   READINESS GATES
nginx-965685897-5lkj7   1/1     Running   0          2m3s   10.42.0.22   g4tzrz2   <none>           <none>
nginx-965685897-6wtzt   1/1     Running   0          2m3s   10.42.1.2    g50zrz2   <none>           <none>
nginx-965685897-q8gsr   1/1     Running   0          2m3s   10.42.2.2    j01ydx2   <none>           <none>
alex@latitude7490:~/ > kubectl get svc -o wide
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE    SELECTOR
kubernetes   ClusterIP      10.43.0.1      <none>          443/TCP        16h    <none>
nginx        LoadBalancer   10.43.35.179   192.168.10.17   80:31589/TCP   7m3s   app=nginx
alex@latitude7490:~/ >
```

nginx is now available at http://192.168.10.17.

## Install Rancher

Followed [instructions](https://technotim.live/posts/rancher-ha-install/):

```sh
kubectl create namespace cattle-system
```
To verify:
```
alex@latitude7490:~/ > kubectl get namespace
NAME              STATUS   AGE
cattle-system     Active   48s
default           Active   17h
kube-node-lease   Active   17h
kube-public       Active   17h
kube-system       Active   17h
metallb-system    Active   17h
```


## Install Longhorn for HA Persistent Volumes
