# Setup WireGuard

This will setup:

* a server in a cloud;
* multiple peers.

## WireGuard Server Setup

I use a free Ubuntu 20 instance in Oracle Cloud.

### Install WireGuard

https://www.digitalocean.com/community/tutorials/how-to-set-up-wireguard-on-ubuntu-20-04

### Choose IPv4 Addresses

These will be used with WireGuard server and peers:

* Range: 172.16.0.0 to 172.16.255.255 - 172.16/16 prefix.
* IPv4 address for the server: 172.16.0.1/16

### Create a WireGuard Server Configuration

By now you should have:

* /etc/wireguard/private.key
* /etc/wireguard/public.key

Edit /etc/wireguard/wg0.conf

```
[Interface]
PrivateKey = base64_encoded_private_key_goes_here
Address = 172.16.0.1/16
ListenPort = 51820
SaveConfig = true

PostUp = iptables -A FORWARD -i wg0 -j ACCEPT
PostUp = iptables -A FORWARD -o wg0 -j ACCEPT
PostUp = iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE

PostDown = iptables -D FORWARD -i wg0 -j ACCEPT
PostDown = iptables -D FORWARD -o wg0 -j ACCEPT
PostDown = iptables -t nat -D POSTROUTING -o ens3 -j MASQUERADE

[Peer]
PublicKey = [redacted]
AllowedIPs = 10.8.0.2/32

```

### Edit /etc/iptables/rules.v4

https://unix.stackexchange.com/questions/653495/oracle-free-tier-wireguard-and-iptables

```
-A INPUT -p udp -m state --state NEW -m udp --dport 51820 -j ACCEPT

-A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i wg0 -j ACCEPT
```

Then

```console
sudo iptables-restore < /etc/iptables/rules.v4
```

### Starting the WireGuard Server

Enable

```console
root@instance-20210930-1149:/etc# sudo systemctl enable wg-quick@wg0.service
Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg0.service → /lib/systemd/system/wg-quick@.service.
```

Start

```console
root@instance-20210930-1149:/etc# sudo systemctl start wg-quick@wg0.service
```

Check status

```console
root@instance-20210930-1149:/etc# sudo systemctl status wg-quick@wg0.service
● wg-quick@wg0.service - WireGuard via wg-quick(8) for wg0
     Loaded: loaded (/lib/systemd/system/wg-quick@.service; enabled; vendor preset: enabled)
     Active: active (exited) since Fri 2021-10-01 02:00:08 UTC; 13s ago
       Docs: man:wg-quick(8)
             man:wg(8)
             https://www.wireguard.com/
             https://www.wireguard.com/quickstart/
             https://git.zx2c4.com/wireguard-tools/about/src/man/wg-quick.8
             https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8
    Process: 1525 ExecStart=/usr/bin/wg-quick up wg0 (code=exited, status=0/SUCCESS)
   Main PID: 1525 (code=exited, status=0/SUCCESS)

Oct 01 02:00:08 instance-20210930-1149 systemd[1]: Starting WireGuard via wg-quick(8) for wg0...
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] ip link add wg0 type wireguard
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] wg setconf wg0 /dev/fd/63
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1548]: Warning: AllowedIP has nonzero host part: 172.16.0.2/16
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] ip -4 address add 172.16.0.1/16 dev wg0
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] ip link set mtu 8920 up dev wg0
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] iptables -A FORWARD -i wg0 -j ACCEPT
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] iptables -A FORWARD -o wg0 -j ACCEPT
Oct 01 02:00:08 instance-20210930-1149 wg-quick[1525]: [#] iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE
Oct 01 02:00:08 instance-20210930-1149 systemd[1]: Finished WireGuard via wg-quick(8) for wg0.
```


## WireGuard Peer Setup
