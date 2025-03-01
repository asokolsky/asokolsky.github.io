# K9s

Sources:

* [k9scli.io](https://k9scli.io/)
* [k9s Cheatsheet](https://www.hackingnote.com/en/cheatsheets/k9s/)

## Installation

On mac:
```sh
brew install k9s
```
On Linux (if you do not mind an old version):
```sh
sudo snap install k9s
```

## Important directories

Run `k9s info` for location of important directories, e.g. logs.

## Configuration Files

Hotkey config:

* MacOS: `~/Library/Application Support/k9s/hotkey.yml`
* Linux: `~/.config/k9s/hotkey.yml` (or $XDG_CONFIG_HOME/k9s/hotkey.yml)
* Windows: `%LOCALAPPDATA%\k9s\hotkey.yml`

`hotkey.yml`

```yaml
hotKey:
  f1:
    shortCut: F1
    description: View pods
    command: pods
  f2:
    shortCut: F2
    description: View deployments
    command: dp
  f3:
    shortCut: F3
    description: View statefulsets
    command: sts
  f4:
    shortCut: F4
    description: View services
    command: service
  f5:
    shortCut: F5
    description: View ingresses
    command: ingress
```

## Key Bindings

Press `?` for summary

### Sort by column

Pods view:

Key|Sort by
---|-------
Shift-A|Age
Shift-C|Cpu
Ctrl-X|CPU/L
Shift-X|Cpu/R
Shift-I|Ip
Shift-M|Mem
Ctrl-Q|Sort MEM/L
Shift-Z|MEM/R
Shift-N|Name
Shift-O|nOde
Shift-P|namesPace
Shift-R|Ready
Shift-S|Status
Shift-T|resTarts

Repeat the command to flip the order.

## Search

1. Press `/`
2. Type search term, e.g. `ked`, press Enter
3. Navigate as usual: use arrows or `j` to go to next, `k` to go to previous.
