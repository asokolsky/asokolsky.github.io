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




