# FreeRADIUS in an LXC Container

## Installation

Got myself latest debian container template - 13 trixie

### Create LXC container

* hostname - radius
* picked debian 13 template
* disk 8GB
* 2 cores CPU
* 1GB RAM
* network - bridge with DHCP - configure static lease on the DHCP server

```sh
apt update && apt upgrade
```

### Install FreeRADIUS

```sh
apt install freeradius freeradius-utils
```

## Configuration
