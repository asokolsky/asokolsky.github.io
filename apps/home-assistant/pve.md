# Home Assistant Integration with Proxmox

Followed https://www.home-assistant.io/integrations/proxmoxve/

```
proxmoxve:
  - host: 192.168.11.20
    username: root
    password: ******
    verify_ssl: false
    realm: pam
    nodes:
      - node: suprox
        vms:
          - 100
          - 101
          - 106
        containers:
          - 102
          - 103
          - 104
          - 105
```
