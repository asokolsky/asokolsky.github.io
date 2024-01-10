# zpool cli

## Create

To setup a RAIDz2 pool:

```sh
zpool create NAME -o ashift=12 raidz2 \
    /dev/disk/by-id/DISK1 /dev/disk/by-id/DISK2 /dev/disk/by-id/DISK3 \
    /dev/disk/by-id/DISK4 /dev/disk/by-id/DISK5
```

Create a mirror pool `tank`:
```sh
sudo zpool create -m /mnt/tank tank mirror sdc1 sdd1
```

To change the mount point:
```sh
sudo zfs set mountpoint=/mnt/btr btr
```

## Status Monitoring / Clear

To look at the pool status:
```sh
zpool status
```

To monitor it in real time:
```sh
zpool status -v 5
```
or even:
```sh
zpool iostat -v 5
```

For example:
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
[the doc](https://docs.oracle.com/cd/E19253-01/819-5461/gaynp/):

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

## Upgrade

```
$ zpool --version
    zfs-0.8.3-1ubuntu12.14
    zfs-kmod-0.8.3-1ubuntu12.14
$ sudo zpool upgrade -a
```

## Scrubbing

```sh
sudo zpool scrub pool0
```
