# Running Home Assistant

Notes on [installation in a VM](../proxmox/home-assistant.md).

Start with https://www.home-assistant.io/docs/configuration/ and VScode add-on.

## Enable SSH Access

[HOWTO: Access the HA OS host itself over ssh](https://community.home-assistant.io/t/howto-how-to-access-the-home-assistant-os-host-itself-over-ssh/263352):

* Install Terminal & SSH add-on
* specify port 22
* edit config YAML and add your public key
* leave password empty
* restart add-on

After that:

```console
alex@latitude7490:~/ > ssh root@homeassistant 'ps ax'
PID   USER     TIME  COMMAND
    1 root      0:00 /package/admin/s6/command/s6-svscan -d4 -- /run/service
   15 root      0:00 s6-supervise s6-linux-init-shutdownd
   17 root      0:00 /package/admin/s6-linux-init/command/s6-linux-init-shutdownd -c /run/s6/basedir -g 3000 -C -B
   22 root      0:00 s6-supervise s6rc-fdholder
   23 root      0:00 s6-supervise s6rc-oneshot-runner
   30 root      0:00 /package/admin/s6/command/s6-ipcserverd -1 -- /package/admin/s6/command/s6-ipcserver-access -v0 -E -l0 -i data/rules -- /package/admin/s6/command/s6-sudod -t 30000 -- /package/admin/s6-rc/command/s6-rc-oneshot-run -l ../.. --
  131 root      0:00 s6-supervise ttyd
  132 root      0:00 s6-supervise sshd
  134 root      0:00 ttyd -p 8099 tmux -u new -A -s homeassistant bash -l
  135 root      0:00 sshd: /usr/sbin/sshd -D -e [listener] 0 of 10-100 startups
  192 root      0:00 sshd: root@notty
  194 root      0:00 ps ax
```

* in Proxmox web GUI drop into VM shell using `login` and then:

```sh
docker cp addon_core_ssh:/root/.ssh/authorized_keys .
```

* then

```sh
systemctl start dropbear
```

* finally:

```console
alex@latitude7490:~/ > ssh ssh://root@homeassistant:22222 'ps'
    PID TTY          TIME CMD
      1 ?        00:00:02 systemd
      2 ?        00:00:00 kthreadd
      3 ?        00:00:00 rcu_gp
      4 ?        00:00:00 rcu_par_gp
      5 ?        00:00:00 slub_flushwq
      6 ?        00:00:00 netns
```

## MQTT Integration

Installation:

* do not use
[MQTT add-on](https://github.com/home-assistant/addons/blob/master/mosquitto/DOCS.md).
It will be deprecated.
* do a [stand-alone MQTT install](../proxmox/mqtt.md).

Add [integration](https://www.home-assistant.io/integrations/mqtt/) to it.

[More about running MQTT](mqtt.html).

## TODO Integrations

* pfSense - e.g for presence https://github.com/travisghansen/hass-pfsense
* Unifi - ?
* TrueNAS - https://community.home-assistant.io/t/truenas-integration/410431
* IPMI - https://community.home-assistant.io/t/ipmi-sensors/279248
* linux sensors to MQTT https://community.home-assistant.io/t/pulling-hardware-sensor-data-from-linux-servers-and-posting-them-to-mqtt/54808
or  https://github.com/Sennevds/system_sensors
