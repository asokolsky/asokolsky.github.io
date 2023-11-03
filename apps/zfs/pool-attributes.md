# Must-have ZPool Attributes

* create zfs pool with `ashift=12` for setting the block size on your disks
* `atime=off` - disables the Accessed attribute, can double IOPS;
* `compression=lz4` - the best compression algorithm;
* `recordsize=(value)`.  Recommended:
    * 16K for VM images and databases;
    * 1M for collections 5-9MB JPG files and GB+ movies;
    * the default 128K is good enough.
* `sync=disabled` - for a huge performance gain;
* `xattr=sa` - set the Linux extended attributes, this will stop the file system
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
