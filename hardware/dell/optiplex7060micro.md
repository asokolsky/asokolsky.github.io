# Dell Optiplex 7060 Micro

## Specifications

[Specs](https://www.dell.com/support/manuals/en-us/optiplex-7060-desktop/opti_7060_mff_setup_specs_manual/system-specifications?guid=guid-ab67ed37-0818-4592-a25c-f04b3a73c18d&lang=en-us)

Component|Details
---------|-------
[CPU](https://www.dell.com/support/manuals/en-us/optiplex-7060-desktop/opti_7060_mff_setup_specs_manual/processor?guid=guid-e178c653-4f96-4d67-8c6e-0d7e87454d21&lang=en-us)|Intel i5-8500T 6C/6T, 9MB up to 3.5GHz, 35W
Motherboard|Intel Q370 chipset
[RAM](https://www.dell.com/support/manuals/en-us/optiplex-7060-desktop/opti_7060_mff_setup_specs_manual/memory?guid=guid-7a6c382e-c8af-4ab3-9b68-be050ee50eaa&lang=en-us)|DDR4 SDRAM 260pin SODIMM 2666 MT/s
[Graphics](https://www.dell.com/support/manuals/en-us/optiplex-7060-desktop/opti_7060_mff_setup_specs_manual/video?guid=guid-b6f3a320-b139-4634-b5c7-56401abf2bfc&lang=en-us)|Intel UHD Graphics 630, HDMI 1.4
SSD|sdb	M2 SATA 128GB SK hynix SC311
Ethernet|Intel I219-LM, rev 10
[Audio](https://www.dell.com/support/manuals/en-us/optiplex-7060-desktop/opti_7060_mff_setup_specs_manual/audio?guid=guid-cde9caee-3518-4f61-8826-c9ca01e7ccc2&lang=en-us)|Realtek ALC3234
[PSU](https://www.dell.com/support/manuals/en-us/optiplex-7060-desktop/opti_7060_mff_setup_specs_manual/power-supply?guid=guid-475c5c8b-0f34-45e9-a49f-b5ba4c3b27c3&lang=en-us)|19.5V 4.62A 90W

M.2 SSD slot supports 2230/2280, SATA & PCIe devices.

M.2 WLAN slot supports 2230, keyed for Integrated or Discrete WiFi,
Intel CNVi or USB2.0/PCIe devices.


## BIOS

Enable turbo.

At the DELL logo screen, press F12 to access the one-time boot menu.

## WLAN Slot

Appears to be compatible with this [2.5Gbps M.2 A- & E-key RTL8125B
NIC](https://www.aliexpress.com/item/3256804057621231.html).

## Fixing Video Tearing

Test [video1](https://www.youtube.com/watch?v=MfL_JkcEFbE),
[video2](https://www.youtube.com/watch?v=2wVC-ZLhIHI).

[linux-intel-graphics-video-tearing](https://www.dedoimedo.com/computers/linux-intel-graphics-video-tearing.html)
did not result in any improvements, even worse, resulted in X-session freeze.
I had to delete `/etc/X11/xorg.conf.d/20-intel.conf`.
