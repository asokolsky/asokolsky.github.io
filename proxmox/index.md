# ProxMox HOWTO

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
* [mqtt install](mqtt.html)
* [performance optimization](guest-performance.html)

## By Guest Type

* [centos7](centos7.html)
* [Home Assistant](home-assistant)
* [octoprint in an LXC Container](octoprint.html)
* [pfSense in a VM](pfSense.html)
* [TrueNAS Core in a VM](truenas.html)
* [Unifi Controller in an LXC container](unifi.html)

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
