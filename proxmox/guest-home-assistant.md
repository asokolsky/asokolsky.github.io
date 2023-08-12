# Home Assistant in a VM

Setting up
[Home Assistant](https://www.home-assistant.io/)
in a VM. Followed
[this guide](https://theprivatesmarthome.com/how-to/install-home-assistant-on-proxmox/).

Also consider: https://github.com/tteck/Proxmox/blob/main/vm/haos-vm-v4.sh

## Identify HAOS Image

Download a KVM qcow2 image from
https://www.home-assistant.io/installation/linux.
Used laptop to un-compress it into `haos_ova-9.2.qcow2`.

Create directory on proxmox to store qcow images:
```
root@fuji:~# ls -la /var/lib/vz/template/
total 16
drwxr-xr-x 4 root root 4096 Jan 19  2022 .
drwxr-xr-x 5 root root 4096 Feb  9  2020 ..
drwxr-xr-x 2 root root 4096 Oct 22 12:19 cache
drwxr-xr-x 2 root root 4096 Oct 22 13:47 iso
root@fuji:~# mkdir /var/lib/vz/template/qcow
```

Copy the image there:

```
alex@latitude7490:~/Downloads/ > scp haos_ova-9.2.qcow2 root@fuji:/var/lib/vz/template/qcow
```

## Create VM

Create a VM.  Replace 104 with your desired VM ID.

```sh
qm create 104 \
    --name hass \
    --bios ovmf \
    --boot order=virtio0 \
    --machine q35 \
    --cores 2 \
    --memory 4096 \
    --scsihw virtio-scsi-pci \
    --net0 model=virtio,bridge=vmbr0 \
    --agent enabled=1 \
    --tablet 0
```

Create an EFI disk:
```sh
qm set 104 --efidisk0 local-lvm:1,format=raw
```


Import disk:
```sh
qm importdisk 104 /var/lib/vz/template/qcow/haos_ova-9.2.qcow2 local-lvm
```
and then attach it to VM:

```sh
qm set 104 --virtio0 local-lvm:vm-104-disk-1
```

Manually changed it to `cache=writeback`.

You no longer need the qcow2 image:
```sh
rm /var/lib/vz/template/qcow/haos_ova-9.2.qcow2
```

Start the VM.

In the router settings create a static lease.

Restart the VM to take advantage of the newly allocated IP address.

## Access Home Assistant

Point your browser to [homeassistant](http://homeassistant:8123).

[Continue with configuration](/apps/home-assistant/).
