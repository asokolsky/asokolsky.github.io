# Formatting (Flash) Disk

## Source

[linuxhint.com/format-usb-drive-linux](https://linuxhint.com/format-usb-drive-linux/)

## Identify it

After you plug the flash disk into your PC:

```sh
alex@latitude7490:~/ > lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda           8:0    1   3.8G  0 disk
├─sda1        8:1    1   212K  0 part
├─sda2        8:2    1   2.8M  0 part
├─sda3        8:3    1  1001M  0 part /media/alex/PVE
└─sda4        8:4    1   300K  0 part
nvme0n1     259:0    0 465.8G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part /boot/efi
└─nvme0n1p2 259:2    0 465.3G  0 part /run/timeshift/backup
```

Flash is identified as `sda`.

Alternatively:

```
alex@latitude7490:~/ > df -T
Filesystem     Type  1K-blocks      Used Available Use% Mounted on
tmpfs          tmpfs   3271684      2028   3269656   1% /run
/dev/nvme0n1p2 ext4  479079112 358214352  96455368  79% /
tmpfs          tmpfs  16358408      6724  16351684   1% /dev/shm
tmpfs          tmpfs      5120         4      5116   1% /run/lock
tmpfs          tmpfs  16358408      3136  16355272   1% /tmp
/dev/nvme0n1p1 vfat     523248     39536    483712   8% /boot/efi
tmpfs          tmpfs   3271680       120   3271560   1% /run/user/1000
/dev/sda1      vfat    3985764      3972   3981792   1% /media/alex/LABEL
```

Observe:
* device `/dev/nvme0n1p2` has `ext4` file system and has 79% of its space used
* `/dev/sda1` has `vfat`  file system and has 1% of its space used.

## Burn ISO

```
 > sudo dd bs=4M if=/tmp/ubuntu-22.04.2-live-server-amd64.iso of=/dev/sda conv=fdatasync status=progress
[sudo] password for alex:
1866465280 bytes (1.9 GB, 1.7 GiB) copied, 1 s, 1.9 GB/s
471+1 records in
471+1 records out
1975971840 bytes (2.0 GB, 1.8 GiB) copied, 101.568 s, 19.5 MB/s
```

## Optional: Wipe it

You may want to use
[wipefs](https://linuxconfig.org/wipefs-linux-command-tutorial-with-examples) to
"not only erase existing signatures on a device, but also to create a report,
which includes them without performing any modification."
[Man page](https://www.man7.org/linux/man-pages/man8/wipefs.8.html).  E.g.:

```sh
sudo wipefs /dev/sda
```

Alternatively:

```sh
alex@latitude7490:~/ > sudo dd if=/dev/zero of=/dev/sda bs=4096 status=progress
[sudo] password for alex:
1332625408 bytes (1.3 GB, 1.2 GiB) copied, 44 s, 30.2 MB/s^C
325404+0 records in
325404+0 records out
1332854784 bytes (1.3 GB, 1.2 GiB) copied, 44.9295 s, 29.7 MB/s
```

## Partition it

You may need to unmount flash:

```sh
sudo umount /dev/sda1
```

Then use
[GNU parted](https://www.gnu.org/software/parted/manual/parted.html):

```
alex@latitude7490:~/ > sudo parted /dev/sda print
Model: CBM USB 2.0 (scsi)
Disk /dev/sda: 4090MB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  4090MB  4089MB  primary  fat32        lba
```


```sh
sudo parted /dev/sda --script -- mklabel msdos
```

Create a primary partition of type fat32 taking all the space:
```sh
sudo parted /dev/sda --script -- mkpart primary fat32 1MiB 100%
```

## Format it

Format disk as exfat:
```sh
sudo mkfs.exfat -n LABEL /dev/sda1
```

As vfat:
```
sudo mkfs.vfat -F32 /dev/sda1
```

## fsck

Depends on the file system used in the previous step, e.g.:
```sh
sudo fsck.exfat /dev/sda1
```
