# Creating a Ubuntu 22.04 VM Template

Image source:
https://cloud-images.ubuntu.com/minimal/releases/jammy/release/

## Download Image

Use the Proxmox GUI to download the image from the above URL

## Customize the image

Use [virt-customize](https://www.libguestfs.org/virt-customize.1.html) to customize downloaded file:

```sh
virt-customize -a /var/lib/vz/template/iso/ubuntu-22.04-minimal-cloudimg-amd64.img --install qemu-guest-agent,jq,htop  --password "ubuntu:password:Password!"
```

## Crete a VM

Use [qm](https://pve.proxmox.com/pve-docs/qm.1.html) to create the VM:
```
qm create 9001 --name ubuntu-2204-cloudinit-template --memory 1024  --cpu cputype=host --cores 2 --sockets 1 --net0 virtio,bridge=vmbr0 --ostype l26
qm importdisk 9001 ubuntu-22.04-minimal-cloudimg-amd64.img local-lvm
qm set 9001 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9001-disk-0,discard=on,iothread=1,size=32G,ssd=1
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --ide2 local-lvm:cloudinit
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent 1
```

```
mv ubuntu-22.04-minimal-cloudimg-amd64.img ubuntu-22.04.qcow2
qemu-img resize ubuntu-22.04.qcow2 32G
qm importdisk 9001 ubuntu-22.04.qcow2 local-lvm
```
