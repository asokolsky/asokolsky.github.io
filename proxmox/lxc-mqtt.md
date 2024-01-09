
# MQTT Mosquitto in an LXC Container

Another option - [install it in a container]().

## Install Broker in an LXC Container

Installed Eclipse Mosquitto broker using the following
[script](https://github.com/tteck/Proxmox/):

```
root@fuji:~# bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/ct/mqtt-v4.sh)"

    __  _______  ____________
   /  |/  / __ \/_  __/_  __/
  / /|_/ / / / / / /   / /
 / /  / / /_/ / / /   / /
/_/  /_/\___\_\/_/ v4/_/

Using Advanced Settings
Using Container Type: 1
Using Root Password: *********
Using Container ID: 1004
Using Hostname: mqtt
Using Disk Size: 2
Allocated Cores: 1
Allocated RAM: 512
Using Bridge: vmbr0
Using IP Address: dhcp
Using Gateway IP Address: Default
Using MAC Address: Default
Using Vlan: Default
Creating a MQTT LXC using the above advanced settings
 ✓ Using local for Template Storage.
 ✓ Using local-lvm for Container Storage.
 ✓ Updated LXC Template List
 ✓ LXC Container 1004 was successfully created.
 ✓ Started LXC Container
 ✓ Set up Container OS
 ✓ Network Connected: 192.168.10.216
 ✓ Internet Connected
 ✓ DNS Resolved github.com to 192.30.255.112
 ✓ Updated Container OS
 ✓ Installed Dependencies
 ✓ Installed Mosquitto MQTT Broker
 ✓ Cleaned
 ✓ Completed Successfully!
```

Picked DHCP.

And then:

```
root@mqtt:~# mosquitto -v
1666652795: mosquitto version 2.0.14 starting
1666652795: Using default config.
1666652795: Starting in local only mode. Connections will only be possible from clients running on this machine.
1666652795: Create a configuration file which defines a listener to allow remote access.
1666652795: For more details see https://mosquitto.org/documentation/authentication-methods/
1666652795: Opening ipv4 listen socket on port 1883.
1666652795: Error: Address already in use
1666652795: Opening ipv6 listen socket on port 1883.
1666652795: Error: Address already in use
```

Added static DHCP lease in pfSense.

Reboot container.

## Configure Broker

HOWTO: http://www.steves-internet-guide.com/install-mosquitto-linux/

Add to `/etc/mosquitto/mosquitto.conf`:

```
listener 1883
allow_anonymous true
socket_domain ipv4
```

Restart is with `systemctl restart mosquitto`.

Verify:
```
root@mqtt:/etc/mosquitto# lsof|grep mos

mosquitto 460                     mosquitto    5u     IPv4           16233252      0t0      TCP *:1883 (LISTEN)

```


## Client

Following http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/


Install with `sudo apt-get install mosquitto-clients`.

Then:

```
alex@latitude7490:~/Projects/asokolsky.github.io/ > mosquitto_pub -h mqtt -m "test message" -t /house/bulb1 -d
Client (null) sending CONNECT
Client (null) received CONNACK (0)
Client (null) sending PUBLISH (d0, q0, r0, m1, '/house/bulb1', ... (12 bytes))
Client (null) sending DISCONNECT
```

To subscribe to all the topics:

```sh
mosquitto_sub -h localhost -t \# -d
```
