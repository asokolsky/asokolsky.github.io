# ZFS Dataset

From
[ZFS 101](https://arstechnica.com/information-technology/2020/05/zfs-101-understanding-zfs-storage-and-performance/)
"A ZFS dataset is roughly analogous to a standard, mounted filesystem". Need it,
e.g. to have ACLs.

## Show properties

References:

* [zfs get](https://openzfs.github.io/openzfs-docs/man/master/8/zfs-get.8.html)
* [zfsprops](https://openzfs.github.io/openzfs-docs/man/master/7/zfsprops.7.html),
[Properties](https://docs.oracle.com/cd/E19253-01/819-5461/gazss/)

Use:
```
# zfs get all tank/downloads
NAME            PROPERTY                VALUE                   SOURCE
tank/downloads  type                    filesystem              -
tank/downloads  creation                Tue Nov  2 14:04 2021   -
tank/downloads  used                    5.15M                   -
tank/downloads  available               4.61T                   -
tank/downloads  referenced              5.15M                   -
tank/downloads  compressratio           1.21x                   -
tank/downloads  mounted                 yes                     -
tank/downloads  quota                   none                    default
tank/downloads  reservation             none                    default
tank/downloads  recordsize              128K                    default
tank/downloads  mountpoint              /mnt/tank/downloads     default
tank/downloads  sharenfs                off                     default
tank/downloads  checksum                sha512                  local
tank/downloads  compression             lz4                     inherited from tank
tank/downloads  atime                   off                     inherited from tank
tank/downloads  devices                 on                      default
tank/downloads  exec                    on                      default
tank/downloads  setuid                  on                      default
tank/downloads  readonly                off                     default
tank/downloads  zoned                   off                     default
tank/downloads  snapdir                 hidden                  default
tank/downloads  aclmode                 passthrough             local
tank/downloads  aclinherit              passthrough             inherited from tank
tank/downloads  createtxg               3020                    -
tank/downloads  canmount                on                      default
tank/downloads  xattr                   sa                      local
tank/downloads  copies                  1                       local
tank/downloads  version                 5                       -
tank/downloads  utf8only                off                     -
tank/downloads  normalization           none                    -
tank/downloads  casesensitivity         insensitive             -
tank/downloads  vscan                   off                     default
tank/downloads  nbmand                  off                     default
tank/downloads  sharesmb                off                     default
tank/downloads  refquota                none                    default
tank/downloads  refreservation          none                    default
tank/downloads  guid                    3495570787300485094     -
tank/downloads  primarycache            all                     default
tank/downloads  secondarycache          all                     default
tank/downloads  usedbysnapshots         0B                      -
tank/downloads  usedbydataset           5.15M                   -
tank/downloads  usedbychildren          0B                      -
tank/downloads  usedbyrefreservation    0B                      -
tank/downloads  logbias                 latency                 default
tank/downloads  objsetid                92                      -
tank/downloads  dedup                   off                     default
tank/downloads  mlslabel                none                    default
tank/downloads  sync                    disabled                inherited from tank
tank/downloads  dnodesize               legacy                  default
tank/downloads  refcompressratio        1.21x                   -
tank/downloads  written                 5.15M                   -
tank/downloads  logicalused             6.17M                   -
tank/downloads  logicalreferenced       6.17M                   -
tank/downloads  volmode                 default                 default
tank/downloads  filesystem_limit        none                    default
tank/downloads  snapshot_limit          none                    default
tank/downloads  filesystem_count        none                    default
tank/downloads  snapshot_count          none                    default
tank/downloads  snapdev                 hidden                  default
tank/downloads  acltype                 nfsv4                   default
tank/downloads  context                 none                    default
tank/downloads  fscontext               none                    default
tank/downloads  defcontext              none                    default
tank/downloads  rootcontext             none                    default
tank/downloads  relatime                on                      default
tank/downloads  redundant_metadata      all                     default
tank/downloads  overlay                 on                      default
tank/downloads  encryption              off                     default
tank/downloads  keylocation             none                    default
tank/downloads  keyformat               none                    default
tank/downloads  pbkdf2iters             0                       default
tank/downloads  special_small_blocks    0                       default
tank/downloads  org.truenas:managedby   192.168.11.100          local
tank/downloads  org.freebsd.ioc:active  yes                     inherited from tank
```

# Manipulate Flags

Use
[zfs set](https://openzfs.github.io/openzfs-docs/man/master/8/zfs-set.8.html    ),
e.g., to turn compression on for the pool:

```sh
zfs set compression=lz4 POOLNAME
```

## Create ZFS Dataset

Use
[zfs create](https://openzfs.github.io/openzfs-docs/man/master/8/zfs-create.8.html):
```sh
zfs create tank/foo
```

## Destroy ZFS Dataset

Use
[zfs destroy](https://openzfs.github.io/openzfs-docs/man/master/8/zfs-destroy.8.html):
```sh
zfs destroy tank/foo
```
