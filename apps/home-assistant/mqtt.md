# Home Assistant - MQTT Integration

Discussion: https://community.home-assistant.io/t/pulling-hardware-sensor-data-from-linux-servers-and-posting-them-to-mqtt/54808

* do NOT use
[MQTT add-on](https://github.com/home-assistant/addons/blob/master/mosquitto/DOCS.md).
It will be deprecated.
* do a [stand-alone MQTT install](/apps/mqtt.html).

Add [integration](https://www.home-assistant.io/integrations/mqtt/) to it.

[More about running MQTT](../mqtt.html).

## Adding Device to Home Assistant

I use [psmqtt](https://github.com/asokolsky/psmqtt) to post metrics from my
(local) server (`suprox`) to the local MQTT broker.

### Manual Integration

[MQTT Sensor](https://www.home-assistant.io/integrations/sensor.mqtt/):

From my `configuration.yaml`:

```yaml
mqtt:
  sensor:
    - state_topic: "psmqtt/suprox/cpu_percent"
      unit_of_measurement: '%'
      state_class: "measurement"
      name: "CPU activity"
      icon: "mdi:gauge"
      unique_id: "suprox_cpu_activity"
    - state_topic: "psmqtt/suprox/virtual_memory/percent"
      unit_of_measurement: '%'
      state_class: "measurement"
      icon: "mdi:gauge"
      name: "Memory use"
      unique_id: "suprox_memory_use"
    - state_topic: "psmqtt/suprox/sensors_temperatures/coretemp/0/"
      unit_of_measurement: '°C'
      device_class: "temperature"
      state_class: "measurement"
      name: "CPU temperature"
      unique_id: "suprox_cpu_temperature"
```


### TODO: [MQTT Discovery](https://www.home-assistant.io/integrations/mqtt/#mqtt-discovery)

https://www.hwinfo.com/forum/threads/hwinfo-integration-into-home-assistant-via-mqtt.8302/

TODO: MQTT Device Discovery:

* [MQTT Discovery](https://www.home-assistant.io/docs/mqtt/discovery/)
* [MQTT Device Discovery](https://www.home-assistant.io/integrations/mqtt/#mqtt-discovery)
