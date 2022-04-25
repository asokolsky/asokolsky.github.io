# Increasing Guest Disk Size

## Increase VM Disk Size

Use Proxmox GUI to give the guest VM more disk.

## Guest

Extend partition size:

```sh
sudo cfdisk
```

Verify with `lsblk`.

Then resize the file system.  For ext4:

```sh
sudo resize2fs /dev/sda3
```
