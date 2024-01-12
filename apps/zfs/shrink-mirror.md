# HOWTO Shrink a (mirror) Pool

## Problem Statement

I have a mirror pool based on 2x 6GB HDs.  I want to migrate it to a 2x 4GB
SSDs.

[zpool status man page](https://openzfs.github.io/openzfs-docs/man/master/8/zpool-status.8.html)

```sh
zpool status tank
```

[zpool list man page](https://openzfs.github.io/openzfs-docs/man/master/8/zpool-list.8.html)
```sh
zpool list tank
```

## Steps

Sources: https://askubuntu.com/questions/1231355/how-can-i-shrink-a-zfs-volume-on-ubuntu-18-04

* add a new vdev to the pool of a smaller size, but sufficient to hold all the
existing data.
* remove the old vdev

### Add a smaller mirror to the existing pool

[zpool add man page](https://openzfs.github.io/openzfs-docs/man/master/8/zpool-add.8.html)

```sh
zpool add tank mirror dev1 dev2
```

### Wait for the resilver to complete

https://openzfs.github.io/openzfs-docs/man/master/8/zpool-iostat.8.html

### Remove the old mirror

[zpool remove man page](https://openzfs.github.io/openzfs-docs/man/master/8/zpool-remove.8.html)
```sh
zpool remove tank mirror-0
```
