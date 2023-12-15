# Setup WireGuard in a Cloud

This will setup:

* a wireguard "server" on a pfSense router;
* multiple peers, including mobile device and another pfSense router

https://www.youtube.com/watch?v=MZf2rOnQ4jc


## Install WireGuard

Install wireguard package.

## Create a Wireguard tunnel

VPN/WireGuard/Tunnels - create new:
* Enable it
* Description: Da wg tunnel
* Listen port: 51820
* Generate a private and public key, save the latter

## Assign Wireguard to an Interface

Named interface tun_wg0

## Create Peers, one per connection

## Firewall Rules
