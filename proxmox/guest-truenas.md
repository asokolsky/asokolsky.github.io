# TrueNAS in a VM on ProxMox

## Create a VM

```
RAM: 8GB
CPU: 2 cores, kvm64, flags=+pdpe1gb;+aes
Bios: Default
Display: SPICE
Machine: q35
HD: SCSI: VirtIO, 32GB, IO thread
DVD: truenas
Network: bridge
```

Note VM id: 101.

## Passthrough

1. Ideally you would pass through the entire host bus adapter.  Or an
[on-board SATA controller](pcie-passthrough-sata.html)
2. If you do not have a host bus adapter and want to just pass SATA drives, do
[passthrough
disk](https://pve.proxmox.com/wiki/Passthrough_Physical_Disk_to_Virtual_Machine_(VM)).

Both worked for me.  The former allows for TrueNAS to perform SMART tests which
is highly desireable.

Passing through a NIC is also desirable, although for a 1Gbps lan the benefits
are marginal.

## Install TrueNAS

As usual.

### Install qemu-guest-agent

[This worked](https://www.truenas.com/community/resources/qemu-guest-agent.167/)!
The latest versions of TrueNAS Scale do have it bundled.

## More

Continue with [TrueNAS Customization](/truenas-scale/).
