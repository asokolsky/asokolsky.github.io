# Disk Commands

Also relevant: [zfs](/apps/zfs/)

## df

Show free disk space including file system type:
```
> df -TH
Filesystem     Type   Size  Used Avail Use% Mounted on
tmpfs          tmpfs  3.4G  2.1M  3.4G   1% /run
/dev/nvme0n1p2 ext4   491G  298G  168G  64% /
tmpfs          tmpfs   17G   13M   17G   1% /dev/shm
tmpfs          tmpfs  5.3M  4.1k  5.3M   1% /run/lock
tmpfs          tmpfs   17G  3.2M   17G   1% /tmp
/dev/nvme0n1p1 vfat   536M   41M  496M   8% /boot/efi
tmpfs          tmpfs  3.4G  148k  3.4G   1% /run/user/1000
```

## du

[du](https://www.linux.org/docs/man1/du.html) estimates file space usage.

Show directory disk usage and use it to sort the files in this dir:
```sh
sudo du -s -- *|sort -s -r -n -k 1,1
```

## Format disk

See [cli-disk-format](cli-disk-format.html).

## Using the Flash disk

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

```sh
mount /dev/sdc2 /media/flash/
```

4. Use it

```
root@suprox:/media# cd flash/
root@suprox:/media/flash# ls -la
total 100
drwxr-xr-x 4 root root 32768 Dec 31  1969  .
drwxr-xr-x 3 root root  4096 Jun 13 19:24  ..
```

5. Unmount it

```sh
umount /media/flash
```
