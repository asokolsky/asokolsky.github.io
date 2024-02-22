# Rapid VM Deployment with Cloud Init and Terraform

## Sources

* [Use Proxmox Cloud-Init to Deploy Your VMs! Kubernetes At Home - Part 2](https://www.youtube.com/watch?v=Kv6-_--y5CM)
* [how to create a proxmox ubuntu cloud init
image](https://austinsnerdythings.com/2021/08/30/how-to-create-a-proxmox-ubuntu-cloud-init-image/)
* [how to deploy VMs in proxmox with terraform](https://austinsnerdythings.com/2021/09/01/how-to-deploy-vms-in-proxmox-with-terraform/)
* https://www.learnlinux.tv/proxmox-ve-how-to-build-an-ubuntu-22-04-template-updated-method/

## Get the OS Image

Use Proxmox GUI to download
[20.04 server cloud image](https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img).
Alternatively use
[22.04 server cloud image](https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img)
or
[22.04 minimal image](https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img)

## Customize the Image

Prerequisite: [libguestfs-tools](https://www.libguestfs.org/).
```sh
apt update -y && apt install libguestfs-tools -y
```

Locate the downloaded image in `/var/lib/vz/template/iso`:
```
root@duo:/var/lib/vz/template/iso# ls -la
total 7551428
drwxr-xr-x 2 root root       4096 May  5 09:35 .
drwxr-xr-x 4 root root       4096 Jan 25  2022 ..
-rw-r--r-- 1 root root  950337536 May  5 09:43 focal-server-cloudimg-amd64.img
-rw-r--r-- 1 root root 3674746880 Apr 19  2022 kubuntu-22.04-desktop-amd64.iso
-rw-r--r-- 1 root root 2312994816 Jun  4  2022 nixos-gnome-x86_64-linux.iso
```

Customize the downloaded image using
[virt-customize](https://www.libguestfs.org/virt-customize.1.html):


```sh
virt-customize -a focal-server-cloudimg-amd64.img \
  --install qemu-guest-agent,jq,htop --root-password password:PASSWORD
```

## Create a Proxmox VM

```sh
qm create 9000 --name "ubuntu-2004-cloudinit-template" --memory 1024 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 focal-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm disk resize 9000 scsi0 32G
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent 1
```

Also in GUI change:

* OS type
* Inform scsi0 as SSD
* Change NIC to use DHCP


## Convert the VM into a Template

```sh
qm template 9000
```

## Test VM Creation from Template


```sh
qm clone 9000 999 --name test-clone-cloud-init
qm set 999 --sshkey ~/.ssh/id_rsa.pub
qm set 999 --ipconfig0 ip=192.168.10.96/24,gw=192.168.10.1
qm start 999
```

Now login into the newly created VM.  First remove known host because SSH key changed:

```sh
ssh-keygen -f "~/.ssh/known_hosts" -R 192.168.10.96
```

Now we can procceed with login:

```sh
ssh -i ~/.ssh/id_rsa ubuntu@192.168.10.96
```

## VM Cleanup

```sh
qm stop 999 && qm destroy 999
```

## Terraform Install

[moved here](terraform/install.html)

## Terraform Plan

Customize it.

## Testing

```console
root@duo:~/terraform# ssh -i ~/.ssh/id_rsa ubuntu@192.168.10.81
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-89-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Oct 22 22:39:40 UTC 2021

  System load:  0.0               Processes:             122
  Usage of /:   18.2% of 9.52GB   Users logged in:       0
  Memory usage: 9%                IPv4 address for eth0: 192.168.10.81
  Swap usage:   0%


0 updates can be applied immediately.


Last login: Fri Oct 22 22:38:00 2021 from 192.168.10.40
ubuntu@test-vm-1:~$ uptime
 22:40:30 up 1 min,  1 user,  load average: 0.00, 0.00, 0.00
ubuntu@test-vm-1:~$ exit
logout
Connection to 192.168.10.81 closed.
```
# Clean-up

Edit main.tf ans set count to 0.  Then:

```console
root@duo:~/terraform# terraform apply
proxmox_vm_qemu.test_server[0]: Refreshing state... [id=duo/qemu/100]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  - destroy

Terraform will perform the following actions:

  # proxmox_vm_qemu.test_server[0] will be destroyed
  - resource "proxmox_vm_qemu" "test_server" {
    ....
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

proxmox_vm_qemu.test_server[0]: Destroying... [id=duo/qemu/100]
proxmox_vm_qemu.test_server[0]: Destruction complete after 4s

Apply complete! Resources: 0 added, 0 changed, 1 destroyed.
```
