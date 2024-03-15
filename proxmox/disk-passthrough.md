# Disk Passthrough to TrueNAS Scale

Follows
[disk passthrough](https://pve.proxmox.com/wiki/Passthrough_Physical_Disk_to_Virtual_Machine_(VM)).


## Identify Disks

```
root@flattop:~# ls -la /dev/disk/by-id
total 0
drwxr-xr-x 2 root root 460 Oct 14 14:25 .
drwxr-xr-x 6 root root 120 Oct 14 14:25 ..
lrwxrwxrwx 1 root root   9 Oct 14 14:25 ata-KINGSTON_SV300S37A120G_50026B773A0059B3 -> ../../sda
lrwxrwxrwx 1 root root   9 Oct 14 14:25 ata-MKNSSDSR120GB_MB2002101005FEB0D -> ../../sdb
...
```

## Add Disks to VM

```
# qm set 101 -scsi2 /dev/disk/by-id/ata-KINGSTON_SV300S37A120G_50026B773A0059B3
# qm set 101 -scsi3 /dev/disk/by-id/ata-MKNSSDSR120GB_MB2002101005FEB0D
```

Ensure the passthrough device has a proper serial number.
Edit /etc/pve/nodes/flattop/qemu-server/101.conf to add device serial
numbers.

```
scsi2: /dev/disk/by-id/ata-KINGSTON_SV300S37A120G_50026B773A0059B3,size=117220824K,serial=50026B773A0059B3
scsi3: /dev/disk/by-id/ata-MKNSSDSR120GB_MB2002101005FEB0D,size=117220824K,serial=MB2002101005FEB0D
```
