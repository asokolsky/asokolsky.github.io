# system_profiler

[man page](https://ss64.com/mac/system_profiler.html)

## Data Tyypes

```
> system_profiler -listDataTypes
Available Datatypes:
SPParallelATADataType
SPUniversalAccessDataType
SPSecureElementDataType
SPApplicationsDataType
SPAudioDataType
SPBluetoothDataType
SPCameraDataType
SPCardReaderDataType
SPiBridgeDataType
SPDeveloperToolsDataType
SPDiagnosticsDataType
SPDisabledSoftwareDataType
SPDiscBurningDataType
SPEthernetDataType
SPExtensionsDataType
SPFibreChannelDataType
SPFireWireDataType
SPFirewallDataType
SPFontsDataType
SPFrameworksDataType
SPDisplaysDataType
SPHardwareDataType
SPInstallHistoryDataType
SPInternationalDataType
SPLegacySoftwareDataType
SPNetworkLocationDataType
SPLogsDataType
SPManagedClientDataType
SPMemoryDataType
SPNVMeDataType
SPNetworkDataType
SPPCIDataType
SPParallelSCSIDataType
SPPowerDataType
SPPrefPaneDataType
SPPrintersSoftwareDataType
SPPrintersDataType
SPConfigurationProfileDataType
SPRawCameraDataType
SPSASDataType
SPSerialATADataType
SPSPIDataType
SPSmartCardsDataType
SPSoftwareDataType
SPStartupItemDataType
SPStorageDataType
SPSyncServicesDataType
SPThunderboltDataType
SPUSBDataType
SPNetworkVolumeDataType
SPAirPortDataType
```

## List Ethernet Hardware

Use `SPEthernetDataType`:

```console
asokolsky in ~ > system_profiler -detailLevel full SPEthernetDataType
Ethernet:

    Apple T2 Controller:

      Bus: USB
      Vendor Name: Apple Inc.
      Product Name: Apple T2 Controller
      Vendor ID: 0x05ac
      Product ID: 0x8233
      USB Link Speed: Up to 480 Mb/s
      Driver: com.apple.driver.usb.cdc.ncm
      BSD Device Name: en5
      MAC Address: ac:de:48:00:11:22
      AVB Support: No
      Maximum Link Speed: 2.5 Gb/s

    USB 10/100/1000 LAN:

      Bus: USB
      Vendor Name: Realtek
      Product Name: USB 10/100/1000 LAN
      Vendor ID: 0x0bda
      Product ID: 0x8153
      USB Link Speed: Up to 5 Gb/s
      Driver: com.apple.DriverKit.AppleUserECM
      BSD Device Name: en7
      MAC Address: 00:00:00:00:00:00
      AVB Support: No
```

## List USB Hardware

Use `SPUSBDataType`:
```
> system_profiler SPUSBDataType
2025-03-13 10:19:45.178 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
2025-03-13 10:19:45.180 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
2025-03-13 10:19:45.181 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
2025-03-13 10:19:45.181 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
2025-03-13 10:19:45.182 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
2025-03-13 10:19:45.183 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
2025-03-13 10:19:45.184 system_profiler[88215:94762258] SPUSBDevice: IOCreatePlugInInterfaceForService failed 0xe00002be
USB:

    USB 3.1 Bus:

      Host Controller Driver: AppleUSBXHCITR
      PCI Device ID: 0x15ec
      PCI Revision ID: 0x0006
      PCI Vendor ID: 0x8086
      Bus Number: 0x00

    USB 3.1 Bus:

      Host Controller Driver: AppleUSBXHCITR
      PCI Device ID: 0x15ec
      PCI Revision ID: 0x0006
      PCI Vendor ID: 0x8086
      Bus Number: 0x01

    USB 3.1 Bus:

      Host Controller Driver: AppleUSBXHCITR
      PCI Device ID: 0x0b27
      PCI Revision ID: 0x0003
      PCI Vendor ID: 0x8086

        USB3.0 Hub:

          Product ID: 0x0b40
          Vendor ID: 0x8087  (Intel Corporation)
          Version: 12.34
          Speed: Up to 10 Gb/s
          Manufacturer: Intel Corporation.
          Location ID: 0x02300000 / 1
          Current Available (mA): 900
          Current Required (mA): 0
          Extra Operating Current (mA): 0

            Dell dock:

              Product ID: 0x0487
              Vendor ID: 0x0bda  (Realtek Semiconductor Corp.)
              Version: 1.57
              Speed: Up to 10 Gb/s
              Manufacturer: Dell Inc.
              Location ID: 0x02340000 / 3
              Current Available (mA): 900
              Current Required (mA): 0
              Extra Operating Current (mA): 0

                USB 10/100/1000 LAN:

                  Product ID: 0x8153
                  Vendor ID: 0x0bda  (Realtek Semiconductor Corp.)
                  Version: 31.11
                  Serial Number: 1113000001
                  Speed: Up to 5 Gb/s
                  Manufacturer: Realtek
                  Location ID: 0x02344000 / 4
                  Current Available (mA): 900
                  Current Required (mA): 112
                  Extra Operating Current (mA): 0

                Dell dock:

                  Product ID: 0x0413
                  Vendor ID: 0x0bda  (Realtek Semiconductor Corp.)
                  Version: 1.22
                  Speed: Up to 5 Gb/s
                  Manufacturer: Dell Inc.
                  Location ID: 0x02343000 / 5
                  Current Available (mA): 900
                  Current Required (mA): 0
                  Extra Operating Current (mA): 0

                    USB3.2 Hub:

                      Product ID: 0x0620
                      Vendor ID: 0x05e3  (Genesys Logic, Inc.)
                      Version: 93.07
                      Speed: Up to 5 Gb/s
                      Manufacturer: GenesysLogic
                      Location ID: 0x02343300 / 28
                      Current Available (mA): 900
                      Current Required (mA): 0
                      Extra Operating Current (mA): 0

        USB2.0 Hub:

          Product ID: 0x5801
          Vendor ID: 0x1d5c  (Fresco Logic Inc.)
          Version: 1.01
          Speed: Up to 480 Mb/s
          Manufacturer: Fresco Logic, Inc.
          Location ID: 0x02100000 / 2
          Current Available (mA): 500
          Current Required (mA): 0
          Extra Operating Current (mA): 0

            Dell dock:

              Product ID: 0x5487
              Vendor ID: 0x0bda  (Realtek Semiconductor Corp.)
              Version: 1.57
              Speed: Up to 480 Mb/s
              Manufacturer: Dell Inc.
              Location ID: 0x02110000 / 7
              Current Available (mA): 500
              Current Required (mA): 0
              Extra Operating Current (mA): 0

                Dell dock:

                  Product ID: 0xb06e
                  Vendor ID: 0x413c  (Dell Inc.)
                  Version: 1.01
                  Speed: Up to 480 Mb/s
                  Location ID: 0x02115000 / 9
                  Current Available (mA): 500
                  Current Required (mA): 100
                  Extra Operating Current (mA): 0

                Dell dock:

                  Product ID: 0x5413
                  Vendor ID: 0x0bda  (Realtek Semiconductor Corp.)
                  Version: 1.22
                  Speed: Up to 480 Mb/s
                  Manufacturer: Dell Inc.
                  Location ID: 0x02113000 / 8
                  Current Available (mA): 500
                  Current Required (mA): 0
                  Extra Operating Current (mA): 0

                    Dell dock:

                      Product ID: 0xb06f
                      Vendor ID: 0x413c  (Dell Inc.)
                      Version: 1.01
                      Speed: Up to 480 Mb/s
                      Location ID: 0x02113500 / 11
                      Current Available (mA): 500
                      Current Required (mA): 100
                      Extra Operating Current (mA): 0

                    USB2.1 Hub:

                      Product ID: 0x0610
                      Vendor ID: 0x05e3  (Genesys Logic, Inc.)
                      Version: 93.07
                      Speed: Up to 480 Mb/s
                      Manufacturer: GenesysLogic
                      Location ID: 0x02113300 / 29
                      Current Available (mA): 500
                      Current Required (mA): 100
                      Extra Operating Current (mA): 0

                        UC40M Audio:

                          Product ID: 0x0b16
                          Vendor ID: 0x1bcf  (Sunplus Innovation Technology Inc.)
                          Version: 12.16
                          Serial Number: 01.00.00
                          Speed: Up to 480 Mb/s
                          Manufacturer: DSJ-211216-ZW
                          Location ID: 0x02113320 / 30
                          Current Available (mA): 500
                          Current Required (mA): 500
                          Extra Operating Current (mA): 0

                        USB2.0 HUB:

                          Product ID: 0x7250
                          Vendor ID: 0x214b
                          Version: 1.00
                          Speed: Up to 480 Mb/s
                          Location ID: 0x02113310 / 31
                          Current Available (mA): 500
                          Current Required (mA): 100
                          Extra Operating Current (mA): 0

                            Keychron K1:

                              Product ID: 0x024f
                              Vendor ID: 0x05ac (Apple Inc.)
                              Version: 1.05
                              Speed: Up to 12 Mb/s
                              Manufacturer: Keychron
                              Location ID: 0x02113314 / 33
                              Current Available (mA): 500
                              Current Required (mA): 100
                              Extra Operating Current (mA): 0

                            USB Receiver:

                              Product ID: 0xc52b
                              Vendor ID: 0x046d  (Logitech Inc.)
                              Version: 12.10
                              Speed: Up to 12 Mb/s
                              Manufacturer: Logitech
                              Location ID: 0x02113311 / 32
                              Current Available (mA): 500
                              Current Required (mA): 98
                              Extra Operating Current (mA): 0

    USB 3.1 Bus:

      Host Controller Driver: AppleIntelCNLUSBXHCI
      PCI Device ID: 0xa36d
      PCI Revision ID: 0x0010
      PCI Vendor ID: 0x8086

    Apple T2 Bus:

      Host Controller Driver: AppleUSBVHCIBCE

        Composite Device:

          Product ID: 0x8104
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.14
          Serial Number: 000000000000
          Speed: Up to 480 Mb/s
          Manufacturer: Apple
          Location ID: 0x80800000 / 6
          Current Available (mA): 500
          Current Required (mA): 500
          Extra Operating Current (mA): 0
          Built-In: Yes

        Touch Bar Backlight:

          Product ID: 0x8102
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.01
          Serial Number: 0000000000000000
          Manufacturer: Apple Inc.
          Location ID: 0x80700000

        Touch Bar Display:

          Product ID: 0x8302
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.01
          Serial Number: 0000000000000000
          Manufacturer: Apple Inc.
          Location ID: 0x80600000

        Apple Internal Keyboard / Trackpad:

          Product ID: 0x0340
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.75
          Serial Number: FM71113041AHYYKCU+WVT
          Manufacturer: Apple Inc.
          Location ID: 0x80500000

        Headset:

          Product ID: 0x8103
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.14
          Serial Number: 000000000000
          Manufacturer: Apple
          Location ID: 0x80400000

        Ambient Light Sensor:

          Product ID: 0x8262
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.01
          Serial Number: 000000000000
          Manufacturer: Apple Inc.
          Location ID: 0x80300000

        FaceTime HD Camera (Built-in):

          Product ID: 0x8514
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.01
          Serial Number: CC2131502X506G734
          Manufacturer: Apple Inc.
          Location ID: 0x80200000

        Apple T2 Controller:

          Product ID: 0x8233
          Vendor ID: 0x05ac (Apple Inc.)
          Version: 2.01
          Serial Number: 0000000000000000
          Manufacturer: Apple Inc.
          Location ID: 0x80100000
```