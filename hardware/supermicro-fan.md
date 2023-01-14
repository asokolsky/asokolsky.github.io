# Supermicro Motherboard Fans

SuperMicro motherboard fans fall into:

* CPU fans, e.g., FAN1, FAN2, etc.
* Peripheral fans, e.g., FANA, FANB, etc.

Motherboard support
[the following fan modes](https://forums.servethehome.com/index.php?resources/supermicro-x9-x10-x11-fan-speed-control.20/):


* Standard: BMC control of both fan zones, with CPU zone based on CPU temp
(target speed 50%) and Peripheral zone based on PCH temp (target speed 50%)
* Optimal: BMC control of the CPU zone (target speed 30%), with Peripheral zone
fixed at low speed (fixed ~30%)
* Full: all fans running at 100%
* Heavy IO: BMC control of CPU zone (target speed 50%), Peripheral zone fixed
at 75%

When a low rpm fan is used AND low rpm threshold is high you will observe:

* fan at full RPM
* fan rpm falls for a while
* repeats

[Fix with ipmitool](../linux/cli-ipmi.html).
