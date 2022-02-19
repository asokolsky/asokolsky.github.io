# Rapid VM Deployment with Cloud Init and Terraform

## Sources

* [how to create a proxmox ubuntu cloud init
image](https://austinsnerdythings.com/2021/08/30/how-to-create-a-proxmox-ubuntu-cloud-init-image/)
* [how to deploy VMs in proxmox with terraform](https://austinsnerdythings.com/2021/09/01/how-to-deploy-vms-in-proxmox-with-terraform/)


## Get the OS Image

Use Proxmox GUI to download image from
`https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img`

## Add Packages to the Image

Prepare proxmox:

```console
root@duo:~# apt update -y && apt install libguestfs-tools -y
```

Install qemu-guest-agent into the image:

```console
root@duo:/# find . -type f -name 'focal-server-*'
find: ‘./var/lib/lxcfs/cgroup’: Input/output error
./var/lib/vz/template/iso/focal-server-cloudimg-amd64.img
root@duo:/# cd var/lib/vz/template/iso/
root@duo:/var/lib/vz/template/iso# ls -la
total 3273424
drwxr-xr-x 2 root root       4096 Sep 27 10:00 .
drwxr-xr-x 5 root root       4096 Dec  4  2020 ..
-rw-r--r-- 1 root root  566951936 Sep 23 16:25 focal-server-cloudimg-amd64.img
-rw-r--r-- 1 root root 2785017856 Dec  4  2020 ubuntu-20.04.1-desktop-amd64.iso
root@duo:/var/lib/vz/template/iso# virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
[   0.0] Examining the guest ...
[   4.8] Setting a random seed
virt-customize: warning: random seed could not be set for this type of guest
[   4.8] Setting the machine ID in /etc/machine-id
[   4.8] Installing packages: qemu-guest-agent
[  23.5] Finishing off
```

## Create a Proxmox VM

```console
root@duo:/var/lib/vz/template/iso# qm create 9000 --name "ubuntu-2004-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
root@duo:/var/lib/vz/template/iso# qm importdisk 9000 focal-server-cloudimg-amd64.img local-lvm
importing disk 'focal-server-cloudimg-amd64.img' to VM 9000 ...
  Logical volume "vm-9000-disk-0" created.
transferred 0.0 B of 2.2 GiB (0.00%)
...
root@duo:/var/lib/vz/template/iso# qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
update VM 9000: -scsi0 local-lvm:vm-9000-disk-0 -scsihw virtio-scsi-pci
root@duo:/var/lib/vz/template/iso# qm set 9000 --boot c --bootdisk scsi0
update VM 9000: -boot c -bootdisk scsi0
root@duo:/var/lib/vz/template/iso# qm set 9000 --ide2 local-lvm:cloudinit
update VM 9000: -ide2 local-lvm:cloudinit
  Logical volume "vm-9000-cloudinit" created.
root@duo:/var/lib/vz/template/iso# qm set 9000 --serial0 socket --vga serial0
update VM 9000: -serial0 socket -vga serial0
root@duo:/var/lib/vz/template/iso# qm set 9000 --agent 1
update VM 9000: -agent 1
```

## Convert the VM into a Template

```console
root@duo:~# qm template 9000
  Renamed "vm-9000-disk-0" to "base-9000-disk-0" in volume group "pve"
  Logical volume pve/base-9000-disk-0 changed.
  WARNING: Combining activation change with other commands is not advised.
root@duo:~#
```

## Test VM Creation from Template


```console
qm clone 9000 999 --name test-clone-cloud-init
qm set 999 --sshkey ~/.ssh/id_rsa.pub
qm set 999 --ipconfig0 ip=192.168.10.96/24,gw=192.168.10.1
qm start 999
```

Now login into the newly created VM.  First remove known host because SSH key changed:

```console
ssh-keygen -f "~/.ssh/known_hosts" -R 192.168.10.96
```

Now we can procceed with login:

```console
ssh -i ~/.ssh/id_rsa ubuntu@192.168.10.96
```

## VM Cleanup

```console
qm stop 999 && qm destroy 999
```

## Install Terraform on Proxmox Server

From [tutorial](https://learn.hashicorp.com/tutorials/terraform/install-cli):


```console
apt -y install lsb-release software-properties-common
```

Add the HashiCorp GPG key:

```console
# curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
```

Add the repository:
```console
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Install Terraform:
```console
apt update && apt install -y terraform
```

## Use API-keys for Authentication

I created a datacenter user asokolsky with Linux PAM authentication.

Create a new API token new_token_id for asokolsky@pam, priviledge unchecked.
Secret: ebf02232-ec86-480c-acdf-4e83fed2c2e6

In the datacenter permission add:

* user permission - add a role to the newly created user asokolsky:
Path=/, User=asokolsky@pam, Role=PVEVMAdmin, Propagate=true

* user permission - Path=/storage/local-lvm, User=asokolsky@pam, Role=Administrator,
Propagate=true

## Terraform Basic Info and Provider Installation

```console
oot@duo:~/terraform# pwd
/root/terraform
root@duo:~/terraform# ls -la
total 12
drwxr-xr-x 2 root root 4096 Oct 22 15:10 .
drwx------ 9 root root 4096 Oct 22 14:56 ..
-rw-r--r-- 1 root root  120 Oct 22 14:57 main.tf
-rw-r--r-- 1 root root    0 Oct 22 14:56 vars.tf
root@duo:~/terraform# cat main.tf
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}
root@duo:~/terraform# terraform init

Initializing the backend...

Initializing provider plugins...
- Finding telmate/proxmox versions matching "2.7.4"...
- Installing telmate/proxmox v2.7.4...
- Installed telmate/proxmox v2.7.4 (self-signed, key ID A9EBBE091B35AFCE)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

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
oot@duo:~/terraform# terraform apply
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
console