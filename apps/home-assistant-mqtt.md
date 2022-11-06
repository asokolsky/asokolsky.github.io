# Home Assistant - MQTT Integration

Discussion: https://community.home-assistant.io/t/pulling-hardware-sensor-data-from-linux-servers-and-posting-them-to-mqtt/54808

* do NOT use
[MQTT add-on](https://github.com/home-assistant/addons/blob/master/mosquitto/DOCS.md).
It will be deprecated.
* do a [stand-alone MQTT install](../proxmox/mqtt.md).

Add [integration](https://www.home-assistant.io/integrations/mqtt/) to it.

[More about running MQTT](mqtt.html).

## Adding Device to HA

I use [psmqtt](https://github.com/asokolsky/psmqtt) to post metrics from my
(local) servers to the local MQTT broker.

TODO:
[MQTT Discovery](https://www.home-assistant.io/integrations/mqtt/#mqtt-discovery)
