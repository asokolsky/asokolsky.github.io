# Shelly Plus Plug US

[Shelly Plus Plug US](https://www.shelly.com/en-us/products/shop/shelly-plus-plug-us),
[Manual and Spec](https://kb.shelly.cloud/knowledge-base/shelly-plug-us),
[pdf manual](https://kb.shelly.cloud/__attachments/64061537/User%20and%20Safety%20Guide?inst-v=37db5b47-02b4-47d2-9c77-9f9b8a60a4f2).

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
network, with name such as `ShellyPlugS-35FA58`. Connect to it.
* Type `192.168.33.1` into the address field of your browser to load
the web interface of Shelly

## Allocate a Static DHCP Lease

In your router settings ensure that the DHCP lease is static.
