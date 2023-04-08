# Playing with ZFS on SSDs

4 SSDs added:

```
root@duo:~# ls -la /dev/disk/by-id/
total 0
drwxr-xr-x 2 root root 700 Apr  6 12:01 .
drwxr-xr-x 6 root root 120 Apr  6 12:01 ..
lrwxrwxrwx 1 root root   9 Apr  6 12:01 ata-KINGSTON_SV300S37A120G_50026B773A0059B3 -> ../../sdb
lrwxrwxrwx 1 root root   9 Apr  6 12:01 ata-MKNSSDSR120GB_MB2002101005FEB0D -> ../../sda
lrwxrwxrwx 1 root root   9 Apr  6 11:57 ata-Samsung_SSD_870_EVO_500GB_S62ANZ0R412333F -> ../../sdd
lrwxrwxrwx 1 root root   9 Apr  6 11:57 ata-Samsung_SSD_870_EVO_500GB_S62ANZ0R412361R -> ../../sdc
...
```

Smaller mirror pool will be `btr`, and a larger one - `bmp`.

Create pool `btr`:

```sh
zpool create btr -o ashift=12 mirror \
    /dev/disk/by-id/ata-KINGSTON_SV300S37A120G_50026B773A0059B3 \
    /dev/disk/by-id/ata-MKNSSDSR120GB_MB2002101005FEB0D
```

List pools:
```
root@duo:~# zpool list
NAME   SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
btr    111G   108K   111G        -         -     0%     0%  1.00x    ONLINE  -
```

Pool status:
```
root@duo:~# zpool status btr
  pool: btr
 state: ONLINE
config:

	NAME                                             STATE     READ WRITE CKSUM
	btr                                              ONLINE       0     0     0
	  mirror-0                                       ONLINE       0     0     0
	    ata-KINGSTON_SV300S37A120G_50026B773A0059B3  ONLINE       0     0     0
	    ata-MKNSSDSR120GB_MB2002101005FEB0D          ONLINE       0     0     0

errors: No known data errors
```

Pool attributes:

```
root@duo:~# zpool get all btr
NAME  PROPERTY                       VALUE                          SOURCE
btr   size                           111G                           -
btr   capacity                       0%                             -
btr   altroot                        -                              default
btr   health                         ONLINE                         -
btr   guid                           7620279620939404162            -
btr   version                        -                              default
btr   bootfs                         -                              default
btr   delegation                     on                             default
btr   autoreplace                    off                            default
btr   cachefile                      -                              default
btr   failmode                       wait                           default
btr   listsnapshots                  off                            default
btr   autoexpand                     off                            default
btr   dedupratio                     1.00x                          -
btr   free                           111G                           -
btr   allocated                      372K                           -
btr   readonly                       off                            -
btr   ashift                         12                             local
btr   comment                        -                              default
btr   expandsize                     -                              -
btr   freeing                        0                              -
btr   fragmentation                  0%                             -
btr   leaked                         0                              -
btr   multihost                      off                            default
btr   checkpoint                     -                              -
btr   load_guid                      17512845552757542485           -
btr   autotrim                       off                            default
btr   compatibility                  off                            default
btr   feature@async_destroy          enabled                        local
btr   feature@empty_bpobj            enabled                        local
btr   feature@lz4_compress           active                         local
btr   feature@multi_vdev_crash_dump  enabled                        local
btr   feature@spacemap_histogram     active                         local
btr   feature@enabled_txg            active                         local
btr   feature@hole_birth             active                         local
btr   feature@extensible_dataset     enabled                        local
btr   feature@embedded_data          active                         local
btr   feature@bookmarks              enabled                        local
btr   feature@filesystem_limits      enabled                        local
btr   feature@large_blocks           enabled                        local
btr   feature@large_dnode            enabled                        local
btr   feature@sha512                 enabled                        local
btr   feature@skein                  enabled                        local
btr   feature@edonr                  enabled                        local
btr   feature@userobj_accounting     enabled                        local
btr   feature@encryption             enabled                        local
btr   feature@project_quota          enabled                        local
btr   feature@device_removal         enabled                        local
btr   feature@obsolete_counts        enabled                        local
btr   feature@zpool_checkpoint       enabled                        local
btr   feature@spacemap_v2            active                         local
btr   feature@allocation_classes     enabled                        local
btr   feature@resilver_defer         enabled                        local
btr   feature@bookmark_v2            enabled                        local
btr   feature@redaction_bookmarks    enabled                        local
btr   feature@redacted_datasets      enabled                        local
btr   feature@bookmark_written       enabled                        local
btr   feature@log_spacemap           active                         local
btr   feature@livelist               enabled                        local
btr   feature@device_rebuild         enabled                        local
btr   feature@zstd_compress          enabled                        local
btr   feature@draid                  enabled                        local
```

Note:

* btr   feature@lz4_compress           active                         local

### Dataset

Create a dataset with the
[best attribute values](https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/):
```sh
zfs create -o atime=off -o xattr=sa -o recordsize=64K btr/dset
```

Note the effect of `atime=off` present in dataset and not in the pool:
```
root@duo:~# mount |grep btr
btr on /btr type zfs (rw,xattr,noacl)
btr/dset on /btr/dset type zfs (rw,noatime,xattr,noacl)
```

Show all the dataset attributes:

```
root@duo:~# zfs get all btr/dset
NAME      PROPERTY              VALUE                  SOURCE
btr/dset  type                  filesystem             -
btr/dset  creation              Thu Apr  6 13:24 2023  -
btr/dset  used                  3.82G                  -
btr/dset  available             104G                   -
btr/dset  referenced            3.82G                  -
btr/dset  compressratio         1.00x                  -
btr/dset  mounted               yes                    -
btr/dset  quota                 none                   default
btr/dset  reservation           none                   default
btr/dset  recordsize            64K                    local
btr/dset  mountpoint            /btr/dset              default
btr/dset  sharenfs              off                    default
btr/dset  checksum              on                     default
btr/dset  compression           lz4                    inherited from btr
btr/dset  atime                 off                    local
btr/dset  devices               on                     default
btr/dset  exec                  on                     default
btr/dset  setuid                on                     default
btr/dset  readonly              off                    default
btr/dset  zoned                 off                    default
btr/dset  snapdir               hidden                 default
btr/dset  aclmode               discard                default
btr/dset  aclinherit            restricted             default
btr/dset  createtxg             16                     -
btr/dset  canmount              on                     default
btr/dset  xattr                 sa                     local
btr/dset  copies                1                      default
btr/dset  version               5                      -
btr/dset  utf8only              off                    -
btr/dset  normalization         none                   -
btr/dset  casesensitivity       sensitive              -
btr/dset  vscan                 off                    default
btr/dset  nbmand                off                    default
btr/dset  sharesmb              off                    default
btr/dset  refquota              none                   default
btr/dset  refreservation        none                   default
btr/dset  guid                  13545457973833480350   -
btr/dset  primarycache          all                    default
btr/dset  secondarycache        all                    default
btr/dset  usedbysnapshots       0B                     -
btr/dset  usedbydataset         3.82G                  -
btr/dset  usedbychildren        0B                     -
btr/dset  usedbyrefreservation  0B                     -
btr/dset  logbias               latency                default
btr/dset  objsetid              87                     -
btr/dset  dedup                 off                    default
btr/dset  mlslabel              none                   default
btr/dset  sync                  standard               default
btr/dset  dnodesize             legacy                 default
btr/dset  refcompressratio      1.00x                  -
btr/dset  written               3.82G                  -
btr/dset  logicalused           3.82G                  -
btr/dset  logicalreferenced     3.82G                  -
btr/dset  volmode               default                default
btr/dset  filesystem_limit      none                   default
btr/dset  snapshot_limit        none                   default
btr/dset  filesystem_count      none                   default
btr/dset  snapshot_count        none                   default
btr/dset  snapdev               hidden                 default
btr/dset  acltype               off                    default
btr/dset  context               none                   default
btr/dset  fscontext             none                   default
btr/dset  defcontext            none                   default
btr/dset  rootcontext           none                   default
btr/dset  relatime              off                    default
btr/dset  redundant_metadata    all                    default
btr/dset  overlay               on                     default
btr/dset  encryption            off                    default
btr/dset  keylocation           none                   default
btr/dset  keyformat             none                   default
btr/dset  pbkdf2iters           0                      default
btr/dset  special_small_blocks  0                      default
```


### Benchmarking

Test writing:
```
root@duo:~# dd if=/dev/zero of=/btr/dset/file.out bs=4096 count=1000000 oflag=direct
1000000+0 records in
1000000+0 records out
4096000000 bytes (4.1 GB, 3.8 GiB) copied, 10.8795 s, 376 MB/s
```
File created:
```
root@duo:~# ls -la /btr/dset/file.out
-rw-r--r-- 1 root root 4096000000 Apr  6 13:40 /btr/dset/file.out
```

Test reading:
```
root@duo:~# dd if=/btr/dset/file.out of=/dev/null bs=4096
1000000+0 records in
1000000+0 records out
4096000000 bytes (4.1 GB, 3.8 GiB) copied, 3.04251 s, 1.3 GB/s
```
