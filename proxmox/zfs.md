# ZFS services on proxmox

My proxmox server passes SATA drives to a [virtualized NAS](/hardware/fuji/) which runs in a VM.
Hence I had to remove ZFS-related services from proxmox:

* zfs-import-cache.service
* zfs-zed.service

```sh
systemctl stop zfs-import-cache.service
systemctl disable zfs-import-cache.service
systemctl stop zfs-zed.service
systemctl disable zfs-zed.service
```
