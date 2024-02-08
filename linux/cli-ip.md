# ip

* [man ip](https://linux.die.net/man/8/ip)
* [RHEL ip cheat sheet](https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf)

## IP queries

SubCommand|Tasks
----------|----
addr|Display IP Addresses and property information (abbreviation of address)
`ip addr`|Show information for all addresses
`ip addr show dev em1`|Display information only for device em1
link|Manage and display the state of all network interfaces
`ip link`|Show information for all interfaces
`ip link show dev em1`|Display information only for device em1
`ip -s link`|Display interface statistics
route|Display and alter the routing table
`ip route`|List all of the route entries in the kernel
maddr|Manage and display multicast IP addresses
`ip maddr`|Display multicast information for all devices
`ip maddr show dev em1`|Display multicast information for device em1
neigh|Show neighbour objects; also known as the ARP table for IPv4
`ip neigh`|Display neighbour objects
`ip neigh show dev em1`|Show the ARP cache for device em1
help|Display a list of commands and arguments for each subcommand
`ip help`|Display ip commands and arguments
`ip addr help`|Display address commands and arguments
`ip link help`|Display link commands and arguments
`ip neigh help`|Display neighbour commands and arguments

## MultiCast Addressing

SubCommand|Tasks
----------|----
maddr add|Add a static link-layer multicast address
ip maddr add 33:33:00:00:00:01 dev em1|Add mutlicast address 33:33:00:00:00:01 to em1
maddr del|Delete a multicast address
ip maddr del 33:33:00:00:00:01 dev em1|Delete address 33:33:00:00:00:01 from em1

## Managing Address

SubCommand|Tasks
----------|----
addr add|Add an address
ip addr add 192.168.1.1/24 dev em1|Add address 192.168.1.1 with netmask 24 to device em1
addr del|Delete an address
ip addr del 192.168.1.1/24 dev em1|Remove address 192.168.1.1/24 from device em1

## Managing Link

SubCommand|Tasks
----------|----
link set|Alter the status of the interface
ip link set em1 up|Bring em1 online
ip link set em1 down|Bring em1 offline
ip link set em1 mtu 9000|Set the MTU on em1 to 9000
ip link set em1 promisc on|Enable promiscuous mode for em1

## Managing Routes

SubCommand|Tasks
----------|----
route add|Add an entry to the routing table
ip route add default via 192.168.1.1 dev em1|Add a default route (for all addresses) via the local gateway 192.168.1.1 that can be reached on device em1
ip route add 192.168.1.0/24 via 192.168.1.1|Add a route to 192.168.1.0/24 via the gateway at 192.168.1.1
ip route add 192.168.1.0/24 dev em1|Add a route to 192.168.1.0/24 that can be reached on device em1
route delete|Delete a routing table entry
ip route delete 192.168.1.0/24 via 192.168.1.1|Delete the route for 192.168.1.0/24 via the gateway at 192.168.1.1
route replace|Replace, or add if not defined, a route
ip route replace 192.168.1.0/24 dev em1|Replace the defined route for 192.168.1.0/24 to use device em1
route get|Display the route an address will take
ip route get 192.168.1.5|Display the route taken for IP 192.168.1.5

## Managing Routes

SubCommand|Tasks
----------|----
neigh add|Add an entry to the ARP Table
ip neigh add 192.168.1.1 lladdr 1:2:3:4:5:6 dev em1|Add address 192.168.1.1 with MAC 1:2:3:4:5:6 to em1
neigh del|Invalidate an entry
ip neigh del 192.168.1.1 dev em1|Invalidate the entry for 192.168.1.1 on em1
neigh replace|Replace, or adds if not defined, an entry to the ARP table
ip neigh replace 192.168.1.1 lladdr 1:2:3:4:5:6 dev em1|Replace the entry for address 192.168.1.1 to use MAC 1:2:3:4:5:6 on em1

## Net-tools vs. IP commands

SubCommand|Tasks
----------|----
Net-tools command|IP commands
arp -a|ip neigh
arp -v|ip -s neigh
arp -s 192.168.1.1 1:2:3:4:5:6|ip neigh add 192.168.1.1 lladdr 1:2:3:4:5:6 dev eth1
arp -i eth1 -d 192.168.1.1|ip neigh del 192.168.1.1 dev eth1
ifconfig -a|ip addr
ifconfig eth0 down|ip link set eth0 down
ifconfig eth0 up|ip link set eth0 up
ifconfig eth0 192.168.1.1|ip addr add 192.168.1.1/24 dev eth0
ifconfig eth0 netmask 255.255.255.0|ip addr add 192.168.1.1/24 dev eth0
ifconfig eth0 mtu 9000|ip link set eth0 mtu 9000
ifconfig eth0:0 192.168.1.2|ip addr add 192.168.1.2/24 dev eth0
netstat|ss
netstat -neopa|ss -neopa
netstat -g|ip maddr
route|ip route
route add -net 192.168.1.0 netmask 255.255.255.0 dev eth0|ip route add 192.168.1.0/24 dev eth0
route add default gw 192.168.1.1|ip route add default via 192.168.1.1