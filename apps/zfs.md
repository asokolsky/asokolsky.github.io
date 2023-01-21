# ZFS Notes

## Sources

* [HOWTO install Proxmox and setup a ZFS
pool](https://blog.quindorian.org/2019/08/how-to-install-proxmox-and-setup-a-zfs-pool.html/#more-2962)
* [ZFS Cheat Sheet](https://hamwaves.com/zfs/en/)

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

```console
$ zpool get ashift tank
NAME  PROPERTY  VALUE   SOURCE
tank  ashift    12      local
```

or

```console
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

```console
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

```console
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

```console
$ zdb -C | grep ashift
            ashift: 12
```

## Replace a disk

```sh
zpool offline vault da3
shutdown
```
replace the disk, then:

```sh
zpool replace vault 1464662681387557667 /dev/da4
```

In case it fails as in:
```console
root@nass:~# zpool replace tank -f /dev/sda
invalid vdev specification
the following errors must be manually repaired:
/dev/sda is part of active pool 'tank'
```

Use
[zpool labelclear](https://openzfs.github.io/openzfs-docs/man/8/zpool-labelclear.8.html):

```
root@nass:~# zpool labelclear -f /dev/sda
root@nass:~# zpool replace tank -f /dev/sda
```

## Replace drives in a 2-way mirror

A mirror:

```console
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

```console
# zpool attach tank da0 da2
# zpool detach tank da0
# zpool set autoexpand=on tank
# zpool online -e tank da0
```

Insert disk.  Then in XigmaNAS GUI:

* Diagnostics\Information now has:
```
da5     WDC WD40EFRX-68WT0N0      n/a      3815448MB     WD-WCC4E0018993      5400 rpm      6.0 Gb/s      Available , Enabled      mps0      LSI SAS2008      n/a      ONLINE
```

* However Disks\Management does not have da5

To remedy:

* In Disks\Management !!!!!! Import Disks - now da5 is listed

* In Disks\Format format with ZFS

```console
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
cp -pR /mnt/vault/movies .
```

## zpool status

```console
root@nass[~]# zpool status tank
  pool: tank
 state: ONLINE
status: One or more devices has experienced an unrecoverable error.  An
	attempt was made to correct the error.  Applications are unaffected.
action: Determine if the device needs to be replaced, and clear the errors
	using 'zpool clear' or replace the device with 'zpool replace'.
   see: https://openzfs.github.io/openzfs-docs/msg/ZFS-8000-9P
  scan: scrub repaired 0B in 07:12:57 with 0 errors on Tue Jan 17 18:12:00 2023
config:

	NAME        STATE     READ WRITE CKSUM
	tank        ONLINE       0     0     0
	  raidz2-0  ONLINE       0     0     0
	    sde     ONLINE       0     0     0
	    sdd     ONLINE       0     0     0
	    sdc     ONLINE       0     0     0
	    sdb     ONLINE       0     0     0
	    sda     ONLINE       0     1     0

errors: No known data errors
```

Note write errors is non-zero.  From
[the doc](https://docs.oracle.com/cd/E19253-01/819-5461/gaynp/index.html):

The `READ` and `WRITE` columns provide a count of I/O errors that occurred on
the device, while the `CKSUM` column provides a count of uncorrectable checksum
errors that occurred on the device. Both error counts indicate a potential
device failure, and some corrective action is needed. If non-zero errors are
reported for a top-level virtual device, portions of your data might have become
inaccessible.

I decided to clear the status, for now, because `smartctl` for `sda` does not
report any problems. `sda` is the oldest drive in the above pool, so I plan to
keep an eye on it.

```console
root@nass[~]# zpool clear tank
root@nass[~]# zpool status tank
  pool: tank
 state: ONLINE
  scan: scrub repaired 0B in 07:12:57 with 0 errors on Tue Jan 17 18:12:00 2023
config:

	NAME        STATE     READ WRITE CKSUM
	tank        ONLINE       0     0     0
	  raidz2-0  ONLINE       0     0     0
	    sde     ONLINE       0     0     0
	    sdd     ONLINE       0     0     0
	    sdc     ONLINE       0     0     0
	    sdb     ONLINE       0     0     0
	    sda     ONLINE       0     0     0

errors: No known data errors
```

Good read:
[Failure Trends in a Large Disk Drive Population](https://static.googleusercontent.com/media/research.google.com/en//archive/disk_failures.pdf)

## Rebuild the pool

Referring to disk as `/dev/sdX` is a bad idea.
Better use serial number as in `/dev/disk/by-id/`:

```
root@nass[~]# lsblk -o NAME,SIZE,SERIAL,WWN,LABEL,FSTYPE
NAME    SIZE SERIAL               WWN                LABEL     FSTYPE
sda     5.5T WD-WX31DB48X2ZY      0x50014ee260e0f1d2 tank      zfs_member
sdb     7.3T VR368JHK             0x5000cca0c3ed20c4 tank      zfs_member
sdc     5.5T WD-C81EX39K          0x50014ee2beea769c tank      zfs_member
sdd     5.5T WD-C81G6HGK          0x50014ee2143f42b0 tank      zfs_member
sde     5.5T ZCT2WLTH             0x5000c500c6881e0b tank      zfs_member
sdf    29.5G SMC0515D91120B964037 0x515d91120b000037
├─sdf1  260M                      0x515d91120b000037           vfat
└─sdf2 29.2G                      0x515d91120b000037 boot-pool zfs_member
root@nass[~]# ll /dev/disk/by-id
total 0
drwxr-xr-x 2 root 360 Jan 18 11:31 ./
drwxr-xr-x 7 root 140 Jan 18 11:31 ../
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-ST6000VN001-2BB186_ZCT2WLTH -> ../../sde
lrwxrwxrwx 1 root   9 Jan 18 11:31 ata-SuperMicro_SSD_SMC0515D91120B964037 -> ../../sdf
lrwxrwxrwx 1 root  10 Jan 18 11:31 ata-SuperMicro_SSD_SMC0515D91120B964037-part1 -> ../../sdf1
lrwxrwxrwx 1 root  10 Jan 18 11:31 ata-SuperMicro_SSD_SMC0515D91120B964037-part2 -> ../../sdf2
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD60EFRX-68MYMN1_WD-WX31DB48X2ZY -> ../../sda
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K -> ../../sdc
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK -> ../../sdd
lrwxrwxrwx 1 root   9 Jan 18 19:23 ata-WDC_WD8003FFBX-68B9AN0_VR368JHK -> ../../sdb
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x5000c500c6881e0b -> ../../sde
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x5000cca0c3ed20c4 -> ../../sdb
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x50014ee2143f42b0 -> ../../sdd
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x50014ee260e0f1d2 -> ../../sda
lrwxrwxrwx 1 root   9 Jan 18 19:23 wwn-0x50014ee2beea769c -> ../../sdc
lrwxrwxrwx 1 root   9 Jan 18 11:31 wwn-0x515d91120b000037 -> ../../sdf
lrwxrwxrwx 1 root  10 Jan 18 11:31 wwn-0x515d91120b000037-part1 -> ../../sdf1
lrwxrwxrwx 1 root  10 Jan 18 11:31 wwn-0x515d91120b000037-part2 -> ../../sdf2
```

Plan:

Export pool tank via TrueNAS GUI.

Then:
```
zpool import \
  -d /dev/disk/by-id/ata-WDC_WD60EFRX-68MYMN1_WD-WX31DB48X2ZY \
  -d /dev/disk/by-id/ata-WDC_WD8003FFBX-68B9AN0_VR368JHK \
  -d /dev/disk/by-id/ata-WDC_WD60EFZX-68B3FN0_WD-C81EX39K \
  -d /dev/disk/by-id/ata-WDC_WD60EFZX-68B3FN0_WD-C81G6HGK \
  -d /dev/disk/by-id/ata-ST6000VN001-2BB186_ZCT2WLTH \
  tank
```

Success!

Except TrueNAS GUI does not recognize the pool.  When imported via
GUI the pool is restored to using `sdX`.
[Bummer](https://www.truenas.com/community/threads/pool-import-cli-vs-gui.107131/).
