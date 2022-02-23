# Note on IPMI Config

This helped to lower the fan rpm threshold - something SuperMicro IPMI web does
not allowed to do. https://calvin.me/quick-how-to-decrease-ipmi-fan-threshold

```console
ipmitool -I lan -U ADMIN -H 10.0.0.4 sensor thresh FAN1 lower 150 225 300
```

More:

  * https://quickpacket.com/billing/knowledgebase/20/Supermicro-Server-Remote-Access-via-IPMItool.html
  * https://docs.oracle.com/cd/E19464-01/820-6850-11/IPMItool.html
  * https://www.thomas-krenn.com/de/wiki/Ipmitool_zur_Sensorabfrage_von_Servern_nutzen

Playing with ipmitool:

```console
[alex@nass ~]$ ipmitool -I lan -U XXX -P XXX -H 192.168.1.35 sdr elist full
CPU Temp         | 01h | ok  |  3.1 | 54 degrees C
System Temp      | 0Bh | ok  |  7.11 | 55 degrees C
Peripheral Temp  | 0Ch | ok  |  7.12 | 36 degrees C
DIMMA1 Temp      | B0h | ok  | 32.64 | 42 degrees C
DIMMA2 Temp      | B1h | ns  | 32.65 | No Reading
DIMMB1 Temp      | B4h | ns  | 32.68 | No Reading
DIMMB2 Temp      | B5h | ns  | 32.69 | No Reading
FAN1             | 41h | ok  | 29.1 | 500 RPM
FAN2             | 42h | ns  | 29.2 | No Reading
FAN3             | 43h | ns  | 29.3 | No Reading
FANA             | 44h | ns  | 29.4 | No Reading
12V              | 30h | ok  |  7.48 | 12.51 Volts
5VCC             | 31h | ok  |  7.49 | 5.08 Volts
3.3VCC           | 32h | ok  |  7.50 | 3.45 Volts
VBAT             | 33h | ok  |  7.51 | 3.20 Volts
Vcpu             | 34h | ok  |  3.52 | 1.02 Volts
VDIMM            | 35h | ok  | 32.53 | 1.23 Volts
PVCCSRAM         | 36h | ok  |  7.54 | 1.04 Volts
P1V05_A          | 37h | ok  |  7.55 | 1.06 Volts
5VSB             | 38h | ok  |  7.56 | 4.95 Volts
3.3VSB           | 39h | ok  |  7.57 | 3.35 Volts
PVNN             | 3Ah | ok  |  7.58 | 0.83 Volts
PVPP             | 3Bh | ok  |  7.59 | 2.71 Volts
P1V538_A         | 3Ch | ok  |  7.60 | 1.55 Volts
1.2V BMC         | 3Dh | ok  |  7.61 | 1.23 Volts
PVCC_REF         | 3Eh | ok  |  7.62 | 1.28 Volts
Chassis Intru    | AAh | ok  | 23.1 |

[alex@nass ~]$ ipmitool -I lan -U XXX -P XXX -H 192.168.1.35 sdr entity 3
CPU Temp         | 01h | ok  |  3.1 | 55 degrees C
Vcpu             | 34h | ok  |  3.52 | 1.02 Volts
[alex@nass ~]$ ipmitool -I lan -U XXX -P XXX -H 192.168.1.35 sdr entity 3.1
CPU Temp         | 01h | ok  |  3.1 | 54 degrees C
[alex@nass ~]$ ipmitool -I lan -U XXX -P XXX -H 192.168.1.35 sdr entity 29.1
FAN1             | 41h | ok  | 29.1 | 600 RPM
[alex@nass ~]$ ipmitool -I lan -U ADMIN -P ADMIN -H 192.168.1.35 sdr type temperature
CPU Temp         | 01h | ok  |  3.1 | 54 degrees C
System Temp      | 0Bh | ok  |  7.11 | 55 degrees C
Peripheral Temp  | 0Ch | ok  |  7.12 | 37 degrees C
DIMMA1 Temp      | B0h | ok  | 32.64 | 42 degrees C
DIMMA2 Temp      | B1h | ns  | 32.65 | No Reading
DIMMB1 Temp      | B4h | ns  | 32.68 | No Reading
DIMMB2 Temp      | B5h | ns  | 32.69 | No Reading

```

## Setting Fan Speed

Get the current fan duty value from CPU-zone (0x00), then peripheral-zone (0x01).

```console
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x00 0x00
 14
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x00 0x01
 14
```

Change case fan duty:

```console
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x01 0x00 0x10

alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x00 0x01
 14
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x00 0x00
 10
```

And then:
```console
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x01 0x01 0x10

alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x00 0x00
 10
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P RSQCQKFTSB -H 192.168.11.22 raw 0x30 0x70 0x66 0x00 0x01
 10
```

Apparently control works only in FULL mode:
https://forums.servethehome.com/index.php?resources/supermicro-x9-x10-x11-fan-speed-control.20/

```console
#set fan mode to "full"
ipmitool raw 0x30 0x45 0x01 0x01

#set fans in "system" zone to lower duty
alex@latitude7490:~$ ipmitool -I lan -U ADMIN -P PASSWORD -H 192.168.11.22 raw 0x30 0x70 0x66 0x01 0x00 0x10
```
