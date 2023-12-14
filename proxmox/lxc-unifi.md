# Unifi Controller in a Proxmox Container

Maybe better yet:
* install: https://github.com/tteck/Proxmox/raw/main/ct/unifi-v4.sh
* update: https://github.com/tteck/Proxmox/blob/main/misc/unifi-update.sh

## UniFi Controller Ports

This is not an exhaustive list.

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

Read [UniFi Installation Script](https://community.ui.com/questions/UniFi-Installation-Scripts-or-UniFi-Easy-Update-Script-or-Ubuntu-16-04-18-04-18-10-19-04-and-19-10-/ccbc7530-dd61-40a7-82ec-22b17f027776).

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

## Set DHCP Server Option 43

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

2. Use the above URL to derive a hex value for DHCP option 43:
01:04:c0:a8:0a:0b

3. Update DHCP server setting.

## Add DNS Alias

Make sure UniFi controller is at DNS name unifi.

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

## 3 Years later

MongoDB 3.6 got obsolete:

```
oot@unicon:~# apt update
Get:1 https://dl.ui.com/unifi/debian stable InRelease [2292 B]
E: Repository 'https://dl.ui.com/unifi/debian stable InRelease' changed its 'Codename' value from 'unifi-7.5' to 'unifi-8.0'
N: This must be accepted explicitly before updates for this repository can be applied. See apt-secure(8) manpage for details.
Do you want to accept these changes and continue updating from this repository? [y/N] Y
Hit:2 http://archive.ubuntu.com/ubuntu focal InRelease
Get:3 http://archive.ubuntu.com/ubuntu focal-updates InRelease [114 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-security InRelease [114 kB]
Ign:5 https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 InRelease
Get:6 https://dl.ui.com/unifi/debian stable/ubiquiti amd64 Packages [714 B]
Hit:7 https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 Release
Err:8 https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 Release.gpg
  The following signatures were invalid: EXPKEYSIG 58712A2291FA4AD5 MongoDB 3.6 Release Signing Key <packaging@mongodb.com>
Get:9 http://archive.ubuntu.com/ubuntu focal-updates/universe amd64 Packages [1140 kB]
Get:10 http://archive.ubuntu.com/ubuntu focal-security/universe amd64 Packages [915 kB]
Fetched 2286 kB in 13s (178 kB/s)
Reading package lists... Done
Building dependency tree
Reading state information... Done
10 packages can be upgraded. Run 'apt list --upgradable' to see them.
W: An error occurred during the signature verification. The repository is not updated and the previous index files will be used. GPG error: https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 Release: The following signatures were invalid: EXPKEYSIG 58712A2291FA4AD5 MongoDB 3.6 Release Signing Key <packaging@mongodb.com>
W: Failed to fetch https://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.6/Release.gpg  The following signatures were invalid: EXPKEYSIG 58712A2291FA4AD5 MongoDB 3.6 Release Signing Key <packaging@mongodb.com>
W: Some index files failed to download. They have been ignored, or old ones used instead.
```

Downloaded latest version of the [Installation Script](https://community.ui.com/questions/UniFi-Installation-Scripts-or-UniFi-Easy-Update-Script-or-Ubuntu-16-04-18-04-18-10-19-04-and-19-10-/ccbc7530-dd61-40a7-82ec-22b17f027776)
and ran it.  It gave me an opportunity to update MondoDB to 4.4.  Outstanding!
