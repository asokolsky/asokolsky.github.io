# Replace a disk

## Replace a disk in a raidz(2)

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

```sh
zpool labelclear -f /dev/sda
zpool replace tank -f /dev/sda
```

## Replace a disk in a 2-way mirror

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

```sh
zpool attach tank da0 da2
zpool detach tank da0
zpool set autoexpand=on tank
zpool online -e tank da0
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
