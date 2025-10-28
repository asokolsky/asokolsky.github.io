# DC 12V 5A PWM Fan Temperature Controller

https://www.aliexpress.us/item/3256807620386964.html

https://www.edn.com/fan-speed-controller/


## Specifications

* Input: 12V DC
* Output: max current: 5A / connector, total: 9A
* Output Range:
    - The first channel 20% -100%, or 40% -100% (TFL = ON)
    - The second channel and the third channel 10% -100%

Note: Above range only for PWM range, the actual control effect will vary depending on the fan.

* Temperature probe parameters: 50K B = 3950
* Thermostat temperature zone error: error depending on the temperature probe, generally 3-5%
* Stall alarm minimum speed: 700-800 rpm

## Dip Switches

* FAN1 is controller by the temp probe.
* FAN2 and FAN3 are controlled via the two pots.
* Beep may not work, because you have to power cycle after the dip switch change

Dip switch|Name|Function
----------|----|--------
1|TFL|FAN1 min PWM: ON - 40%, OFF - 20%
2|TP1|Set Accelerated/Full Speed Temperature
3|TP2|Set Accelerated/Full Speed Temperature
4|BF1|FAN1 FAN2 stall alarm
5|BF2|FAN1 FAN2 stall alarm

TP1|TP2|Acceleration Temperature|Full Speed Temperature
---|---|------------------------|----------------------
OFF|OFF|35°C|45°C
ON|OFF|40°C|55°C
OFF|ON|50°C|70°C
ON|ON|60°C|90°C

When the temperature lower than the accelerated temperature, then output at the minimum rotation speed; when it exceed over the full temperature, then always output at full speed.

BF1 BF2 (No. 4,5): corresponds FAN1 FAN2 stall alarm function switch, when the corresponding open channel fan break down, the controller will alarm with sound and light (works with buzzer), alarm will automatically eliminated when the fan is rotated recovery .
If BF1 and BF2 both are open (ON), the FAN1, FAN2 have any one or both stops, the controller will alarm.
