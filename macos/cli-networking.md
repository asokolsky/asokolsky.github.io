# Networking CLIs

## Interfaces

Use [ifconfig](https://ss64.com/mac/ifconfig.html) to show interfaces:
```sh
ifconfig
```

To reformat the output as json use [jc](https://github.com/kellyjonbrazil/jc):
```sh
ifconfig | jc --ifconfig
```
## networksetup

Better yet use native CLI [networksetup](https://ss64.com/mac/networksetup.html).
```sh
networksetup -listAllNetworkServices
```
or
```
networksetup -listAllHardwarePorts
```

```sh
networksetup -listPreferredWirelessNetworks en0
```

```sh
networksetup -listNetworkServiceOrder
```

## Routes

Show Routes:
```sh
netstat -rn
```
