# ProxMox HOWTO

[pve-docs](https://pve.proxmox.com/pve-docs/) and
[pve-admin-guide](https://pve.proxmox.com/pve-docs/pve-admin-guide.html).

## Storage Management

https://pve.proxmox.com/wiki/Storage

## Proxmox Tasks

* cli: [vm, container, template manipulation](cli-proxmox.html),
[systemps.sh](systemps.sh)
* [setup](setup.html)
* [PCIe passthrough](pcie-passthrough.html)
* [Kernels cleanup](kernels.html)
* [network](network.html)
* [nut](nut.html)
* ProxMox as [file server](file-server.html) and [nas](nas.html)
* [Postfix as forwarder](postfix.html)
* [Power Saving](power.html)
* [Rapid VM Deployment with Cloud Init and Terraform](cloud-init.html)
* [Use Portainer to support docker containers](portainer.html)

## Guest Tasks

* [disk resize](guest-disk-resize.html)
* [performance optimization](guest-performance.html)

## Guests

In a VM:

* [centos7](guest-centos7.html)
* [Home Assistant](guest-home-assistant.html)
* [kubuntu desktop in a VM](guest-kubuntu.html)
* [pfSense in a VM](guest-pfSense.html)
* [TrueNAS in a VM](guest-truenas.html)
* [XigmaNAS in a VM](guest-xigmanas.html)

In an LXC container:

* [mqtt](lxc-mqtt.html)
* [octoprint](lxc-octoprint.html)
* [myspeed](lxc-myspeed.html)
* [prusalink](lxc-prusalink.html)
* [Unifi Controller](lxc-unifi.html)
* [vault](lxc-vault.html)

mjpg-streamer in a [docker](mjpg-streamer-docker.html) or
[LXC](mjpg-streamer-lxc.html).

## More

From [Proxmox scripts](https://github.com/tteck/Proxmox/):

* [Update All LXC's Fast & Easy](https://github.com/tteck/Proxmox/blob/main/misc/update-lxcs.sh)
* [MQTT lxc](https://github.com/tteck/Proxmox/blob/main/ct/mqtt-v4.sh)
* [MariaDB lxc](https://github.com/tteck/Proxmox/blob/main/ct/mariadb-v4.sh)
* [Prometheus lxc](https://github.com/tteck/Proxmox/blob/main/ct/prometheus-v4.sh)
* [Graphana lxc](https://github.com/tteck/Proxmox/raw/main/ct/grafana-v4.sh)

## Troubleshooting

In case your browser complains about certificate being reused:
```sh
rm /etc/pve/local/pve-ssl.*
rm /etc/pve/pve-root-ca.pem
pvecm updatecerts --force
systemctl restart pveproxy
```
