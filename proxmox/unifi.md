# Proxmox Containter with Unifi Controller

## UniFi Controller Ports

This is not exhaustive list.

Incoming traffic:

* TCP, port 8080 for HTTP, for devices to report
* TCP, port 8443 for HTTPS, GUI
* UDP, port 3478 for
[STUN](https://help.ui.com/hc/en-us/articles/115015457668-UniFi-Troubleshooting-STUN-Communication-Errors).

## UniFi Device Defaults

UniFi device with settings reset:

* has ssh credentials ubnt/ubnt;
* expects to find unifi controller at `http://unifi:8080/inform`

Hence there is a benefit of having the controller on host `unifi`

## Sources

* [UniFi Network - Add new devices](https://help.ui.com/hc/en-us/articles/360012622613)
* [UniFi - Layer 3 Adoption for Remote UniFi Network Applications](https://help.ui.com/hc/en-us/articles/204909754-UniFi-Device-Adoption-Methods-for-Remote-UniFi-Controllers)
* https://www.youtube.com/watch?v=FiZDit-xNvk
* https://proxmox-openvz.blogspot.com/2019/09/installing-ubiquiti-unifi-controller-as.html
* https://pve.proxmox.com/wiki/Command_line_tools

## Download container template

In Proxmox Datacenter\server\local open Template, download Ubuntu-20 container template

## Create container

I used:

* Ubuntu 20 template
* Disk: 8GB
* Cores: 1
* RAM: 2GB
* Swap: 512MB
* Net: DHCP

## Upgrade Container

Usual apt update/upgrade

## Download install script

Read [UniFi Installation Scripts](https://community.ui.com/questions/UniFi-Installation-Scripts-or-UniFi-Easy-Update-Script-or-Ubuntu-16-04-18-04-18-10-19-04-and-19-10-/ccbc7530-dd61-40a7-82ec-22b17f027776).

Then

```
root@unicon:~# wget https://get.glennr.nl/unifi/install/unifi-6.0.28.sh
--2020-10-24 11:44:03--  https://get.glennr.nl/unifi/install/unifi-6.0.28.sh
Resolving get.glennr.nl (get.glennr.nl)... 51.38.48.41
Connecting to get.glennr.nl (get.glennr.nl)|51.38.48.41|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 149804 (146K) [text/x-sh]
Saving to: ‘unifi-6.0.28.sh’

unifi-6.0.28.sh                     100%[=================================================================>] 146.29K   104KB/s    in 1.4s

2020-10-24 11:44:06 (104 KB/s) - ‘unifi-6.0.28.sh’ saved [149804/149804]

root@unicon:~# chmod a+x unifi-6.0.28.sh
```

## Controller Setup

Point browser at https://unicon:8443

Step 1/6: Name controller: Apricot960

etc

## Update DHCP Server Option 43

[Unifi L3 Adoption with DHCP Option 43](https://tcpip.wtf/en/unifi-l3-adoption-with-dhcp-option-43-on-pfsense-mikrotik-and-others.htm)

1. Identify unifi controller host name and IP:

```
alex@latitude7490:~$ nslookup
> server 192.168.10.1
Default server: 192.168.10.1
Address: 192.168.10.1#53
> unicon
Server:		192.168.10.1
Address:	192.168.10.1#53

Name:	unicon.lan
Address: 192.168.10.11
```

2. Use the above URL to derive a hex value for DHCP option 43: 01:04:c0:a8:0a:0b

3. Update DHCP server setting.

## Allow for root to ssh

Edit /etc/ssh/sshd_config and add

```
PermitRootLogin yes
```

and then

```
systemctl restart sshd
```

## Picking the Version of the Ubiquiti Controller

Note `stable` here:

```
root@unicon:/etc/apt/sources.list.d# cat 100-ubnt-unifi.list
deb https://www.ui.com/downloads/unifi/debian stable ubiquiti
```
