# Setup WireGuard on a Router

This will setup:

* a wireguard "server" on a pfSense router;
* multiple peers, including mobile device and another pfSense router

Sources:
* Netgate wireguard recipes:
[remote access](https://docs.netgate.com/pfsense/en/latest/recipes/wireguard-ra.html),
[site-to-milti-site](https://docs.netgate.com/pfsense/en/latest/recipes/wireguard-s2ms.html),
[site-to-site](https://docs.netgate.com/pfsense/en/latest/recipes/wireguard-s2s.html).
* https://www.youtube.com/watch?v=MZf2rOnQ4jc


## Install WireGuard

Install wireguard package.

## Network architecture

* Tunnel subnet: 10.10.0.0/16
*

## Create a Wireguard tunnel

VPN/WireGuard/Tunnels - create new:
* Enable it
* Description: Da wg tunnel
* Listen port: 51820
* Generate a private and public key, save the latter

## Assign Wireguard to an Interface

* Named interface tun_wg0;
* assign a static IP on a tunnel subnet /16, save it;
* do NOT block private networks
* do NOT block bogon networks

## Create Peers, one per connection

Use the other side public key and endpoint.

Allowed IPs:

* add the other side subnet
* add WG subnet

## Firewall Rules
