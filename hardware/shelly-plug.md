# Shelly Plus Plug US

[Shelly Plus Plug US](https://www.shelly.cloud/en-us/products/product-overview/shelly-plus-plug-us),
[Manual and Spec](https://kb.shelly.cloud/knowledge-base/shelly-plug-us)

From the manual:

* Place Shelly into the power socket without any device/load connected to the
Shelly.
* Press the Power Button. The LED should flash red/blue. This
means that Shelly is in AP mode.
* Press the Button again and the LED will turn off. This means that Shelly is
turned off.

LED States:

Color|Blink|Description
-----|-----|-----------
Blue|quick|AP Mode
Blue|slow|STA Mode (no cloud)
Blue|still|STA Mode (connected to cloud)
Red|still|Relay On
Red & Blue|quick|FW Update


## Installation/Initial inclusion

* Place Shelly into the socket and wait the WiFi LED to flash red/blue.
* CAUTION! If the WiFi LED does not flash red/blue, press and
hold the Button for 10 seconds. After the LED begins to flash red/
blue, release it.
* When the LED is flashing red/blue, Shelly has created a WiFi
network, with name such as ShellyPlugS-35FA58. Connect to it.
* Type 192.168.33.1 into the address field of your browser to load
the web interface of Shelly

## Allocate a Static DHCP Lease

In your router settings ensure that the DHCP lease is static.
