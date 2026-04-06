# Unifi OS Server in an LXC Container

There is a script to install
[Unify OS Server in an LXC](https://github.com/community-scripts/ProxmoxVE/blob/main/ct/unifi-os-server.sh)!

See [help page](https://community-scripts.org/scripts/unifi-os-server?from=scripts&fromQ=unify).

## Preparation

1. Use GUI to back-up the existing Unifi Controller which I ran in the LXC.
2. Copy the MAC address to ensure that the new Unifi OS Server comes up with the same IP address.
3. Shutdown the controller using proxmox GUI, modify its settings to NOT start at boot.

## Installation

Run:
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/unifi-os-server.sh)"
```

Chose an advanced option, non-default settings:

* (default) UniFi OS Server requires a privileged LXC container.
* root password
* container ID
* (default) DHCP
* enter the MAC address
* enable root SSH access

## Post Install

1. Upgrade the components
2. Imported the exported backup settings.
