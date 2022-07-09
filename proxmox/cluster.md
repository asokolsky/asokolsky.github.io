# Proxmox Cluster

Clusterming may be beneficial even without advanced features, such as high availability and replication:

PROS:

* migrate VMs (NO passthrough!) between the nodes;
* single GUI for administering multiple nodes.

CONS:

* Uses more power
* Makes changes to network config almost impossible

More:

* Offial doc on
[Cluster Management](https://pve.proxmox.com/pve-docs/chapter-pvecm.html)
* [how does quorum work](https://www.reddit.com/r/Proxmox/comments/gne7mx/new_to_clusters_how_does_quorum_exactly_work/)
* [QDevice in Docker](https://raymii.org/s/tutorials/Proxmox_VE_7_Corosync_QDevice_in_Docker.html)

## Ceph

[Ceph](https://en.wikipedia.org/wiki/Ceph_(software)) is a
"software-defined storage platform that implements object storage on a single distributed computer cluster and provides 3-in-1 interfaces for
object-, block- and file-level storage."

Proxmox doc: https://pve.proxmox.com/wiki/Deploy_Hyper-Converged_Ceph_Cluster

More: https://www.apalrd.net/posts/2022/cluster_ceph/

### Before you begin

Proxmox cluster should be configured.

### Monitors

Ceph monitors are responsible for Ceph synchronization.  One will be created by default.
You need at least three.

### Manager

This is a GUI to display, e.g. statistics. One is sufficient.

1. Install the manager package with `apt install ceph-mgr-dashboard`
1. Enable the dashboard module with `ceph mgr module enable dashboard`
1. Create a self-signed certificate with `ceph dashboard create-self-signed-cert`
1. Create a password for the new admin user and store it to a file. Ceph is actually picky
about password rules here. `echo MyPassword1 > password.txt`
1. Create a new admin user in the Ceph dashboard with `ceph dashboard ac-user-create <name> -i password.txt adminstrator`,
where ‘administrator’ is the role that Ceph has by default, so this user can then create more users through the dashboard.
1. Delete the password file - `rm password.txt`
1. Restart the manager or disable and re-enable the dashboard:
`ceph mgr module disable dashboard` and `ceph mgr module enable dashboard`.
I rebooted the node here. The documentation suggests this shouldn’t be required.

### Storage

Ceph needs its own storage - Object Storage Daemon (OSD).  You will need to dedicate the entire disk to its exclusive use.


### CLI

Find out versions of the components:

```console
root@pmox1:~# ceph versions
{
    "mon": {
        "ceph version 16.2.9 (a569859f5e07da0c4c39da81d5fb5675cd95da49) pacific (stable)": 1
    },
    "mgr": {
        "ceph version 16.2.9 (a569859f5e07da0c4c39da81d5fb5675cd95da49) pacific (stable)": 1
    },
    "osd": {
        "ceph version 16.2.9 (a569859f5e07da0c4c39da81d5fb5675cd95da49) pacific (stable)": 1
    },
    "mds": {},
    "overall": {
        "ceph version 16.2.9 (a569859f5e07da0c4c39da81d5fb5675cd95da49) pacific (stable)": 3
    }
}
```

Status display:
```console
root@pmox1:~# ceph status
  cluster:
    id:     2b45cd07-668d-49da-91eb-ee8d1dd41883
    health: HEALTH_WARN
            OSD count 1 < osd_pool_default_size 3
 
  services:
    mon: 1 daemons, quorum pmox1 (age 8m)
    mgr: pmox1(active, since 7m)
    osd: 1 osds: 1 up (since 8m), 1 in (since 3d)
 
  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   5.4 MiB used, 119 GiB / 119 GiB avail
    pgs:     
 ```
And then after

* another node is added into the cluster
* metadata servers are created 
* CephFS is created

we have:
```console
root@pmox1:~# ceph status
  cluster:
    id:     2b45cd07-668d-49da-91eb-ee8d1dd41883
    health: HEALTH_WARN
            Degraded data redundancy: 22/66 objects degraded (33.333%), 13 pgs degraded, 288 pgs undersized
            OSD count 2 < osd_pool_default_size 3
            too many PGs per OSD (288 > max 250)
 
  services:
    mon: 1 daemons, quorum pmox1 (age 25m)
    mgr: pmox1(active, since 25m)
    mds: 1/1 daemons up, 1 standby
    osd: 2 osds: 2 up (since 13m), 2 in (since 13m)
 
  data:
    volumes: 1/1 healthy
    pools:   3 pools, 288 pgs
    objects: 22 objects, 12 KiB
    usage:   13 MiB used, 231 GiB / 231 GiB avail
    pgs:     22/66 objects degraded (33.333%)
             275 active+undersized
             13  active+undersized+degraded
 
  progress:
    Global Recovery Event (0s)
      [............................] 
 
```



