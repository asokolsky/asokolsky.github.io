# Disk Commands

## df

```sh
> df -h
df: /run/user/1000/doc: Operation not permitted
Filesystem      Size  Used Avail Use% Mounted on
udev            3.8G     0  3.8G   0% /dev
tmpfs           781M  1.9M  779M   1% /run
/dev/nvme0n1p2  457G   56G  379G  13% /
tmpfs           3.9G  123M  3.7G   4% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/nvme0n1p1  511M   15M  497M   3% /boot/efi
tmpfs           781M   52K  781M   1% /run/user/1000
```

## du

[du](https://www.linux.org/docs/man1/du.html) estimates file space usage.

Show how much space is used by directories in this folder:

```sh
du -sh -- *
```

## Format disk

See [cli-disk-format.md](cli-disk-format.html).

## ZFS

<<<<<<< HEAD
See [zfs.md](../apps/zfs.html)

## Mounting Flash disk

1. Identify it

```
# lsblk
OR
# fdisk -l
OR
$ sudo fdisk -l
```

2. Create mount point

```
root@suprox:/media# mkdir flash
```

3. Mount it

```
root@suprox:/media# mount /dev/sdc2 /media/flash/
```

4. Use it

```
root@suprox:/media# cd flash/
root@suprox:/media/flash# ls -la
total 100
drwxr-xr-x 4 root root 32768 Dec 31  1969  .
drwxr-xr-x 3 root root  4096 Jun 13 19:24  ..
drwxr-xr-x 2 root root 32768 Jun 12 18:47 'Plebs S01'
drwxr-xr-x 2 root root 32768 Jun 12 18:42 'Wire in the Blood S01'
```

5. Unmount it

```
# umount /media/flash
```

Also see [zfs.md](/apps/zfs.html)
