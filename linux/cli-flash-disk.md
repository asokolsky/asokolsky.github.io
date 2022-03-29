# Formatting (Flash) Disk

## Source

https://linuxhint.com/format-usb-drive-linux/

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

## Optional: Wipe it

```sh
alex@latitude7490:~/ > sudo dd if=/dev/zero of=/dev/sda bs=4096 status=progress
[sudo] password for alex:
1332625408 bytes (1.3 GB, 1.2 GiB) copied, 44 s, 30.2 MB/s^C
325404+0 records in
325404+0 records out
1332854784 bytes (1.3 GB, 1.2 GiB) copied, 44.9295 s, 29.7 MB/s
```

## Partition

You may need to unmount flash:

```sh
sudo umount /dev/sda1
```

Then partition it:

```sh
sudo parted /dev/sda --script -- mklabel msdos
```
Create a primary partition of type fat32 taking all the space:
```
sudo parted /dev/sda --script -- mkpart primary fat32 1MiB 100%
```
Format it:
```
sudo mkfs.vfat -F32 /dev/sda1
```
