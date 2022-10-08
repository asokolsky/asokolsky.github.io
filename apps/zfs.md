# ZFS Notes

## Sources

[HOWTO install Proxmox and setup a ZFS
pool](https://blog.quindorian.org/2019/08/how-to-install-proxmox-and-setup-a-zfs-pool.html/#more-2962)


## zpool CLI

To setup a RAIDz2 pool:

```sh
zpool create NAME -o ashift=12 raidz2 \
    /dev/disk/by-id/DISK1 /dev/disk/by-id/DISK2 /dev/disk/by-id/DISK3 \
    /dev/disk/by-id/DISK4 /dev/disk/by-id/DISK5
```

To look at the pool status:
```sh
zpool status
```

Create a dataset for ISO storage:

```sh
zfs create POOL/ISO
```

## Must-have Pool Attributes

* create zfs pool with ashift=12 for setting the block size on your disks
* atime=off - disables the Accessed attribute, can double IOPS;
* compression=lz4 - the best compression algorithm;
* recordsize=(value).  Recommended:
    * 16K for VM images and databases;
    * 1M for collections 5-9MB JPG files and GB+ movies;
    * the default 128K is good enough.
* sync=disabled - for a huge performance gain;
* xattr=sa - set the Linux extended attributes, this will stop the file system
from writing tiny files and write directly to the inodes;

To turn compression on for the pool:

```sh
zfs set compression=lz4 POOLNAME
```

Check:

```sh
$ zpool get ashift tank
NAME  PROPERTY  VALUE   SOURCE
tank  ashift    12      local
```

or

```sh
$ zpool get all tank
NAME  PROPERTY                       VALUE                          SOURCE
tank  size                           5.45T                          -
tank  capacity                       0%                             -
tank  altroot                        /mnt                           local
tank  health                         ONLINE                         -
tank  guid                           13342146495687011760           -
tank  version                        -                              default
tank  bootfs                         -                              default
tank  delegation                     on                             default
tank  autoreplace                    off                            default
tank  cachefile                      /data/zfs/zpool.cache          local
tank  failmode                       continue                       local
tank  listsnapshots                  off                            default
tank  autoexpand                     on                             local
tank  dedupratio                     1.00x                          -
tank  free                           5.44T                          -
tank  allocated                      12.1G                          -
tank  readonly                       off                            -
tank  ashift                         12                             local
tank  comment                        -                              default
tank  expandsize                     -                              -
tank  freeing                        0                              -
tank  fragmentation                  0%                             -
tank  leaked                         0                              -
tank  multihost                      off                            default
tank  checkpoint                     -                              -
tank  load_guid                      10696914392094791930           -
tank  autotrim                       off                            default
tank  feature@async_destroy          enabled                        local
tank  feature@empty_bpobj            active                         local
tank  feature@lz4_compress           active                         local
tank  feature@multi_vdev_crash_dump  enabled                        local
tank  feature@spacemap_histogram     active                         local
tank  feature@enabled_txg            active                         local
tank  feature@hole_birth             active                         local
tank  feature@extensible_dataset     active                         local
tank  feature@embedded_data          active                         local
tank  feature@bookmarks              enabled                        local
tank  feature@filesystem_limits      enabled                        local
tank  feature@large_blocks           enabled                        local
tank  feature@large_dnode            enabled                        local
tank  feature@sha512                 active                         local
tank  feature@skein                  enabled                        local
tank  feature@userobj_accounting     active                         local
tank  feature@encryption             enabled                        local
tank  feature@project_quota          active                         local
tank  feature@device_removal         enabled                        local
tank  feature@obsolete_counts        enabled                        local
tank  feature@zpool_checkpoint       enabled                        local
tank  feature@spacemap_v2            active                         local
tank  feature@allocation_classes     enabled                        local
tank  feature@resilver_defer         enabled                        local
tank  feature@bookmark_v2            enabled                        local
tank  feature@redaction_bookmarks    enabled                        local
tank  feature@redacted_datasets      enabled                        local
tank  feature@bookmark_written       enabled                        local
tank  feature@log_spacemap           active                         local
tank  feature@livelist               enabled                        local
tank  feature@device_rebuild         enabled                        local
tank  feature@zstd_compress          enabled                        local
```

Or using zdb:

```sh
$ sudo zdb -e -C tank
MOS Configuration:
        version: 5000
        name: 'tank'
        state: 0
        txg: 856
        pool_guid: 13342146495687011760
        errata: 0
        hostid: 2746588504
        hostname: ''
        com.delphix:has_per_vdev_zaps
        vdev_children: 1
        vdev_tree:
            type: 'root'
            id: 0
            guid: 13342146495687011760
            create_txg: 4
            children[0]:
                type: 'mirror'
                id: 0
                guid: 17654950249616959709
                metaslab_array: 69
                metaslab_shift: 34
                ashift: 12
                asize: 5999022833664
                is_log: 0
                create_txg: 4
                com.delphix:vdev_zap_top: 66
                children[0]:
                    type: 'disk'
                    id: 0
                    guid: 15524432170139117586
                    path: '/dev/gptid/92a7ff20-3a98-11ec-b453-37c073549e50'
                    create_txg: 4
                    com.delphix:vdev_zap_leaf: 67
                children[1]:
                    type: 'disk'
                    id: 1
                    guid: 16235157590705019568
                    path: '/dev/gptid/92b7fb49-3a98-11ec-b453-37c073549e50'
                    create_txg: 4
                    com.delphix:vdev_zap_leaf: 68
        features_for_read:
            com.delphix:hole_birth
            com.delphix:embedded_data
```


atime details:

```sh
$ mount|grep tank
tank on /mnt/tank (zfs, local, noatime, nfsv4acls)
tank/home on /mnt/tank/home (zfs, local, noatime, nfsv4acls)
tank/music on /mnt/tank/music (zfs, local, noatime, nfsv4acls)
tank/movies on /mnt/tank/movies (zfs, local, noatime, nfsv4acls)
tank/iocage on /mnt/tank/iocage (zfs, local, noatime, nfsv4acls)
tank/iocage/download on /mnt/tank/iocage/download (zfs, local, noatime, nfsv4acls)
tank/iocage/images on /mnt/tank/iocage/images (zfs, local, noatime, nfsv4acls)
tank/iocage/jails on /mnt/tank/iocage/jails (zfs, local, noatime, nfsv4acls)
tank/iocage/log on /mnt/tank/iocage/log (zfs, local, noatime, nfsv4acls)
tank/iocage/releases on /mnt/tank/iocage/releases (zfs, local, noatime, nfsv4acls)
tank/iocage/templates on /mnt/tank/iocage/templates (zfs, local, noatime, nfsv4acls)

```


## ZFS Command History

On my (old) nass:

```sh
zpool create -f tank raidz2 /dev/ada0 /dev/ada1 /dev/ada2 /dev/ada3 /dev/ada4
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=lz4 -o dedup=off -o sync=standard tank/home
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=lz4 -o dedup=off -o sync=standard tank/downloads
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=off -o dedup=off -o sync=standard tank/moviesMore
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=off -o dedup=off -o sync=standard tank/movies
zfs create -o aclinherit=restricted -o aclmode=discard -o atime=off -o casesensitivity=sensitive -o compression=lz4 -o dedup=off -o sync=standard tank/music

zpool offline tank 10462354999995531015
zpool import -d /dev -f -a
zpool replace tank 10462354999995531015 ada1
zpool import -d /dev -f -a
zpool import -d /dev -f -a

```

And:

```sh
$ zdb -C | grep ashift
            ashift: 12
```

## Replace a disk

```sh
zpool offline vault da3
shutdown
```
replace the disk
```sh
zpool replace vault 1464662681387557667 /dev/da4
```

## Replace drives in a 2-way mirror

A mirror:

```sh
# zpool status tank
  pool: tank
 state: ONLINE
  scan: scrub repaired 0 in 0h0m with 0 errors on Thu Apr 26 17:10:10 2012
config:

        NAME        STATE     READ WRITE CKSUM
        tank        ONLINE       0     0     0
          mirror-0  ONLINE       0     0     0
            da1     ONLINE       0     0     0
            da0     ONLINE       0     0     0

errors: No known data errors
```

Make it a 3-way mirror:

```sh
# zpool attach tank da0 da2
# zpool detach tank da0
# zpool set autoexpand=on tank
# zpool online -e tank da0
```

Insert disk.  Then in GUI Disgnostics\Information now has:
```
da5     WDC WD40EFRX-68WT0N0      n/a      3815448MB     WD-WCC4E0018993      5400 rpm      6.0 Gb/s      Available , Enabled      mps0      LSI SAS2008      n/a      ONLINE
```

Disks\Management however does not have da5


Disks\Management !!!!!! Import Disks - now da5 is listed

Disks\Format format with ZFS

```
kern.geom.debugflags: 0 -> 16
Deleting MBR and partition table...
2048+0 records in
2048+0 records out
1048576 bytes transferred in 0.924642 secs (1134035 bytes/sec)
2048+0 records in
2048+0 records out
1048576 bytes transferred in 0.206532 secs (5077063 bytes/sec)
Deleting GEOM metadata...
1+0 records in
1+0 records out
512 bytes transferred in 0.000155 secs (3303821 bytes/sec)
kern.geom.debugflags: 16 -> 0
Done!
```

* Create virtual device VeryTemp with one HD.
* Create a pool VeryTemp from that virtual device

```sh
$ cp -pR /mnt/vault/movies .
```

### Use Case

* removed 3 old disks
* inserted 3 disks
* power up

XigmaNAS Diagnostics\Information\Disks - now has new drive

Disks\Management - Clear Config and Import disks
Change for every disk:
Description - Western Digital Red
Hard disk standby time - 30min
APM - 127
Acoustic level - disabled
SMART - activated

Disks\Format - new disk unavailable ;-(
restart
Disks\Format - new disk unavailable ;-(

Disks|ZFS|Pools|Management - remove old pool
Disks|ZFS|Configuration - Synch

Disks|Format - new disk unavailable!
    File System - ZFS, no option for 4K sectors

Disks|ZFS|Pools|Tools
    attach device VeryTemp da2 da3

Disks|ZFS|Pools|Information - you can see resilvering!

Rename the pool by export/import
