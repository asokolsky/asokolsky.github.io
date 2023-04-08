# ProxMox as a File Server

Here I use a
[bind mount](https://www.itsembedded.com/sysadmin/proxmox_bind_unprivileged_lxc/)
to pass a ZFS dataset to an unprivileged LXC running smbd.

Also:
[step-by-step-install-w-efi-zfs-ssd-cache-file-server](https://forum.proxmox.com/threads/step-by-step-install-w-efi-zfs-ssd-cache-file-server.41619/)

## Proxmox Storage Config

I have on duo:

```
root@duo:~# zpool list
NAME   SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
btr    111G  3.82G   107G        -         -     0%     3%  1.00x    ONLINE  -
root@duo:~# zpool status btr
  pool: btr
 state: ONLINE
config:

	NAME                                             STATE     READ WRITE CKSUM
	btr                                              ONLINE       0     0     0
	  mirror-0                                       ONLINE       0     0     0
	    ata-KINGSTON_SV300S37A120G_50026B773A0059B3  ONLINE       0     0     0
	    ata-MKNSSDSR120GB_MB2002101005FEB0D          ONLINE       0     0     0

errors: No known data errors
```

I have on fuji:

```console
root@fuji:~# zpool list -v
NAME        SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
tank        464G   688K   464G        -         -     0%     0%  1.00x    ONLINE  -
  sda1      464G   688K   464G        -         -     0%  0.00%      -  ONLINE
root@fuji:~# mount|grep tank
tank on /tank type zfs (rw,xattr,noacl)
```

## Get Container Template

Using the Proxmox GUI downloaded
`debian-11-turnkey-fileserver_17.1-1_amd64.tar.gz`.

## Create Container

Choose:

* host name, password,
* pick the template,
* disk - accept default, 8GB, this one is for OS alone,
* Cores: 2,
* Memory: accept the default 512M,
* IP address: DHCP,
* mount turnkey-linux-fileserver.

Do not start it yet.

## Configure Container in ProxMox

Start at boot: Yes.

Resources\Mount point (mp0): /tank, mp=/mnt/media,mountoptions=noatime

or edit /etc/pve/lxc/<containerID>.conf

```
mp0:/tank,mp=/mnt/media,mountoptions=noatime
```


## Configure Container in GUI

Start the container. I ssh'ed as root.

WebDAV (CGI):    https://192.168.10.143
Web shell:       https://192.168.10.143:12320
Webmin:          https://192.168.10.143:12321
SMB/CIFS:        \\192.168.10.143 (ports 139/445)
SSH/SFTP:        root@192.168.10.143 (port 22)

## LXC User/Group ID -> Hypervisor User/Group ID

You will need to mess with hypervisor's file system permission and/or ownership.
See the first reference for details.

## Performance Benchmarking/Optimization

As tested from my laptop, iperf3 gives 950 Mbits/sec for both send and receive.

Large file transfer in Mint Nemo from laptop to the smb share - 65MB/sec.
smbd is observed in htop to consume 24-30% of CPU.
Pretty disappointing.

Need to review smbd network settings.  The following had little to no effect.

### global section

As [recommended](https://wiki.samba.org/index.php/Performance_Tuning) removed
`socket options`.

Added:
```
use sendfile = yes
aio read size = 16384
aio write size = 16384
```

### share section(s)

I decided to NOT follow
[recommendations](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/assembly_tuning-the-performance-of-a-samba-server_monitoring-and-managing-system-status-and-performance#proc_tuning-shares-with-directories-that-contain-a-large-number-of-files_assembly_tuning-the-performance-of-a-samba-server)
and to have the case preserved.
```
case sensitive = true
default case = lower
#preserve case = yes
#short preserve case = yes
```
