# CentOS7 on ProxMox

Intent: create a VM with CentOS7 on a ProxMox appliance.

## Get CentOS7 Distribution

Need to have CentOS7 ISO in storage local in ProxMox.

I downloaded to my laptop
[CentOS-7-x86_64-Minimal-2003.iso](https://mirrors.edge.kernel.org/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso)
and then uploaded it to ProxMox storage local.

## Create a VM with CentOS7

Now you should be able to select the uploaded ISO when creating the VM.

I pretty much used the defaults.  Except set cores to 2.

## OS Installation

Start the VM.  Do install. Reboot.

Setup network:
[how-to-setup-network-after-rhelcentos-7-minimal-installation](https://lintut.com/how-to-setup-network-after-rhelcentos-7-minimal-installation/)

## OS Customization

As described in other files in this repository.
