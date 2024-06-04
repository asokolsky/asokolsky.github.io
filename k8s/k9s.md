# K9s

Sources:

* [k9scli.io](https://k9scli.io/)

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

## More

https://www.hackingnote.com/en/cheatsheets/k9s/
