# ProxMox CLI

## ProxMox Update and Upgrade

From [System Software Updates](https://pve.proxmox.com/wiki/System_Software_Updates):

```sh
apt-get update
apt-get dist-upgrade
```


## Restart web GUI
```sh
service pveproxy restart
```

## Physical Volumes

Description|Command
-----------|-------
List all PVs|`pvs`
Create a PV|`pvcreate <disk-device-name>`
Remove a PV|`pvremove <disk-device-name>`

## Volume Groups

Description|Command
-----------|-------
List|`vgs`
Create a VG|`vgcreate <vg-name> <disk-device-name>`
Remove a VG|`vgremove <vg-name>`

## Logical Volumes

Description|Command
-----------|-------
List|`lvs`
Create|`lvcreate -L <lv-size> -n <lv-name> <vg-name>`
Remove a LV|`lvremove <vg-name>/<lv-name>`

## Storage Management

Description|Command
-----------|-------
Create a new storage|`pvesm add <type> <storage> [OPTIONS]`
Allocate disk images|`pvesm alloc <storage> <vmid> <filename> <size> [OPTIONS]`
Delete volume|`pvesm free <volume> [OPTIONS]`
Delete storage configuration|`pvesm remove <storage>`
List storage content|`pvesm list <storage> [OPTIONS]`
An alias for pvesm scan lvm|`pvesm lvmscan`
An alias for pvesm scan lvmthin|`pvesm lvmthinscan`
List local LVM volume groups|`pvesm scan lvm`
List local LVM Thin Pools|`pvesm scan lvmthin <vg>`
Get status for all datastores|`pvesm status [OPTIONS]`

## VMs

### VM Query

Description|Command
-----------|-------
Show VMs|`cat /etc/pve/.vmlist`
Show VMs|`qm list`
Show VM status|`qm status <vmid>`
Show VMs command line|`qm showcmd <vmid> [OPTIONS]`

### VM Manipulation

Description|Command
-----------|-------
Create or restore a VM|`qm create <vmid>`
Start a VM|`qm start <vmid>`
Suspend virtual machine|`qm suspend <vmid>`
Shutdown a VM|`qm shutdown <vmid>`
Reboot a VM|`qm reboot <vmid>`
Reset a VM|`qm reset <vmid>`
Stop a VM|`qm stop <vmid>`
Destroy the VM and all used/owned volumes, permissions and firewall rules|`qm destroy <vmid>`
If the above fails because the machine is locked|`qm unlock <vmid>`
Enter Qemu Monitor interface|`qm monitor <vmid>`
Get the VM config (both current and pending)|`qm pending <vmid>`
Send key event to virtual machine|`qm sendkey <vmid> <key> [OPTIONS]`
Clone a VM|`qm clone <vmid> <newid>`
Migrate a VM|`qm migrate <vmid> <target-node>`
Clean up resources for a VM|`qm cleanup <vmid> <clean-shutdown> <guest-requested>`
Create a Template|`qm template <vmid> [OPTIONS]`
Set virtual machine options (synchronous)|`qm set <vmid> [OPTIONS]`

### VM Disk Manipulation

Description|Command
-----------|-------
Import a disk image (supported by qemu-img(1)) as an unused disk in a VM|`qm disk import <vmid> <source> <storage>`
Move volume to different storage or to a different VM|`qm disk move <vmid> <disk> [<storage>] [OPTIONS]`
Rescan to update disk sizes and unused disk images|`qm disk rescan [OPTIONS]`
Extend volume size|`qm disk resize <vmid> <disk> <size> [OPTIONS]`
Unlink/delete disk images|`qm disk unlink <vmid> --idlist <string> [OPTIONS]`
rescan volumes|`qm rescan`

### VM Snapshot

Description|Command
-----------|-------
List all snapshots|`qm listsnapshot <vmid>`
Snapshot a VM|`qm snapshot <vmid> <snapname>`
Delete a snapshot|`qm delsnapshot <vmid> <snapname>`
Rollback a snapshot|`qm rollback <vmid> <snapname>`

### Guest VM Operations

Description|Command
-----------|-------
Execute Qemu Guest Agent commands|`qm guest cmd <vmid> <command>`
Executes the given command via the guest agent|`qm guest exec <vmid> [<extra-args>] [OPTIONS]`
Gets the status of the given pid started by the guest-agent|`qm guest exec-status <vmid> <pid>`
Sets the password for the given user to the given password|`qm guest passwd <vmid> <username> [OPTIONS]`

### VM CloudInit

Description|Command
-----------|-------
Get an auto-generated cloudinit config|`qm cloudinit dump <vmid> <type>`
Get the cloudinit config with both current and pending values|`qm cloudinit pending <vmid>`
Regenerate and change cloudinit config drive|`qm cloudinit update <vmid>`

### Misc VM Ops

Description|Command
-----------|-------
Open a terminal using a serial device. The VM need to have a serial device configured, e.g., serial0: socket|`qm terminal <vmid> [OPTIONS]`
Proxy VM VNC traffic to stdin/stdout|`qm vncproxy <vmid>`

## Containers

### Container Templates

Description|Command
-----------|-------
list all templates|`pveam available`
list all templates|`pveam list <storage>`
Download appliance templates|`pveam download <storage> <template>`
Remove a template|`pveam remove <template-path>`
Update Container Template Database|`pveam update`

Working with container templates:
```sh
pveam update
pveam available
pveam download local ubuntu-18.10-standard_18.10-2_amd64.tar.gz
```

### Container Query

Description|Command
-----------|-------
List containers|`pct list`
Show CT status|`pct status <vmid> [OPTIONS]`
Get container config|`pct config <vmid> [OPTIONS]`
Print the list of assigned CPU sets|`pct cpusets`
Get the container config, including pending changes|`pct pending <vmid>`

### Container Manipulation

Description|Command
-----------|-------
Create or restore a container|`pct create <vmid> <ostemplate> [OPTIONS]`
Start the container|`pct start <vmid> [OPTIONS]`
Create a container clone/copy|`pct clone <vmid> <newid> [OPTIONS]`
Suspend the container (experimental)|`pct suspend <vmid>`
Resume the container|`pct resume <vmid>`
Stop the container|`pct stop <vmid>`
Stop all the processes in the container|`pct stop <vmid> [OPTIONS]`
Clean shutdown of the container, see lxc-stop(1)|`pct shutdown <vmid> [OPTIONS]`
Destroy the container|`pct destroy <vmid> [OPTIONS]`
Migrate the container to another node. Creates a new migration task.|`pct migrate <vmid> <target> [OPTIONS]`
Reboot the container, apply the pending changes|`pct reboot <vmid> [OPTIONS]`
Create or restore a container|`pct restore <vmid> <ostemplate> [OPTIONS]`
Set container options|`pct set <vmid> [OPTIONS]`
Create a Template|`pct template <vmid>`
Unlock the container|`pct unlock <vmid>`
Enter into a container (without password)|`pct enter <vmid>`

### Container Disk Manipulation

Description|Command
-----------|-------
Get the current disk usage|`pct df <vmid>`
Run a fsck on a container volume|`pct fsck <vmid> [OPTIONS]`
Run fstrim on a chosen CT and its mountpoints|`pct fstrim <vmid> [OPTIONS]`
Mount the container's filesystem on the host. This will hold a lock on the container. For emergency only - prevents further ops other than start and stop.|`pct mount <vmid>`
Move a rootfs-/mp-volume to a different storage or to a different container.|`pct move-volume <vmid> <volume> [<storage>] [<target-vmid>] [<target-volume>] [OPTIONS]`
Unmount the container's filesystem|`pct unmount <vmid>`
Resize a container mount point|`pct resize <vmid> <disk> <size> [OPTIONS]`
Rescan to update disk sizes and unused disk images|`pct rescan [OPTIONS]`
Connect to container|`pct enter <vmid>`

### Container Examples

Launch a console for the specified container.
```sh
pct console <vmid> [OPTIONS]
```

Launch a shell for the specified container.
```sh
pct enter <vmid>
```

Launch a command inside the specified container.
```sh
pct exec <vmid> [<extra-args>]
```

Copy a file from the container to the local system.
```sh
pct pull <vmid> <path> <destination> [OPTIONS]
```

Copy a local file to the container.
```sh
pct push <vmid> <file> <destination> [OPTIONS]
```

Snapshot a container.
```sh
pct snapshot <vmid> <snapname> [OPTIONS]
```

List all the container snapshots.
```
pct listsnapshot <vmid>
```
Rollback LXC state to specified snapshot.
```sh
pct rollback <vmid> <snapname> [OPTIONS]
```
Delete a LXC snapshot.
```sh
pct delsnapshot <vmid> <snapname> [OPTIONS]
```
