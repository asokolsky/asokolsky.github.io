# Samba Server in Container

## Image

https://hub.docker.com/r/servercontainers/samba

## docker-compose

```yaml
---
version: "3.9"

services:
  samba:
    container_name: smbd
    image: docker.io/servercontainers/samba:latest
    restart: unless-stopped
    environment:
      ACCOUNT_username: password
      TZ: 'EST5EDT'
      UID_username: 1234
      SAMBA_VOLUME_CONFIG_sharename: "[sharename]; path=/shares/location; available = yes; browsable = yes; writable = no; read only = yes; force user>
    network_mode: host
    networks:
      - default
    ports:
      - "137:137/udp"
      - "138:138/udp"
      - "139:139/tcp"
      - "445:445/tcp"
    volumes:
      - /your/data:/shares/location

networks:
  default:
```
