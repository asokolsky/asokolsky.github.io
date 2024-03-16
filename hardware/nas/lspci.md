## NAS PCIe Devices

```
alex@nass:~/ > lspci -nnkq
00:00.0 Host bridge [0600]: Intel Corporation Atom Processor C3000 Series System Agent [8086:1980] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series System Agent [15d9:0969]
00:04.0 Host bridge [0600]: Intel Corporation Atom Processor C3000 Series Error Registers [8086:19a1] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series Error Registers [15d9:0969]
00:05.0 Generic system peripheral [0807]: Intel Corporation Atom Processor C3000 Series Root Complex Event Collector [8086:19a2] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series Root Complex Event Collector [15d9:0969]
	Kernel driver in use: pcieport
00:06.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series Integrated QAT Root Port [8086:19a3] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series Integrated QAT Root Port [15d9:0969]
	Kernel driver in use: pcieport
00:10.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series PCI Express Root Port #6 [8086:19aa] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series PCI Express Root Port [15d9:0969]
	Kernel driver in use: pcieport
00:11.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series PCI Express Root Port #7 [8086:19ab] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series PCI Express Root Port [15d9:0969]
	Kernel driver in use: pcieport
00:12.0 System peripheral [0880]: Intel Corporation Atom Processor C3000 Series SMBus Contoller - Host [8086:19ac] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series SMBus Contoller - Host [15d9:0969]
	Kernel driver in use: ismt_smbus
	Kernel modules: i2c_ismt
00:13.0 SATA controller [0106]: Intel Corporation Atom Processor C3000 Series SATA Controller 0 [8086:19b2] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series SATA Controller 0 [15d9:0969]
	Kernel driver in use: ahci
	Kernel modules: ahci
00:14.0 SATA controller [0106]: Intel Corporation Atom Processor C3000 Series SATA Controller 1 [8086:19c2] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series SATA Controller 1 [15d9:0969]
	Kernel driver in use: ahci
	Kernel modules: ahci
00:15.0 USB controller [0c03]: Intel Corporation Atom Processor C3000 Series USB 3.0 xHCI Controller [8086:19d0] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series USB 3.0 xHCI Controller [15d9:0969]
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
00:16.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series Integrated LAN Root Port #0 [8086:19d1] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series Integrated LAN Root Port [15d9:0969]
	Kernel driver in use: pcieport
00:17.0 PCI bridge [0604]: Intel Corporation Atom Processor C3000 Series Integrated LAN Root Port #1 [8086:19d2] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series Integrated LAN Root Port [15d9:0969]
	Kernel driver in use: pcieport
00:18.0 Communication controller [0780]: Intel Corporation Atom Processor C3000 Series ME HECI 1 [8086:19d3] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series ME HECI 1 [15d9:0969]
00:1f.0 ISA bridge [0601]: Intel Corporation Atom Processor C3000 Series LPC or eSPI [8086:19dc] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series LPC or eSPI [15d9:0969]
00:1f.2 Memory controller [0580]: Intel Corporation Atom Processor C3000 Series Power Management Controller [8086:19de] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series Power Management Controller [15d9:0969]
00:1f.4 SMBus [0c05]: Intel Corporation Atom Processor C3000 Series SMBus controller [8086:19df] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series SMBus controller [15d9:0969]
	Kernel driver in use: i801_smbus
	Kernel modules: i2c_i801
00:1f.5 Serial bus controller [0c80]: Intel Corporation Atom Processor C3000 Series SPI Controller [8086:19e0] (rev 11)
	Subsystem: Super Micro Computer Inc Atom Processor C3000 Series SPI Controller [15d9:0969]
01:00.0 Co-processor [0b40]: Intel Corporation Atom Processor C3000 Series QuickAssist Technology [8086:19e2] (rev 11)
	Subsystem: Intel Corporation Atom Processor C3000 Series QuickAssist Technology [8086:0000]
	Kernel driver in use: c3xxx
	Kernel modules: qat_c3xxx
03:00.0 PCI bridge [0604]: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge [1a03:1150] (rev 03)
	Subsystem: Super Micro Computer Inc AST1150 PCI-to-PCI Bridge [15d9:0969]
04:00.0 VGA compatible controller [0300]: ASPEED Technology, Inc. ASPEED Graphics Family [1a03:2000] (rev 30)
	DeviceName: ASPEED Video AST2400
	Subsystem: Super Micro Computer Inc ASPEED Graphics Family [15d9:0969]
	Kernel driver in use: ast
	Kernel modules: ast
05:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e4] (rev 11)
	DeviceName: Intel Ethernet X553 SGMII #1
	Subsystem: Intel Corporation Ethernet Connection X553 1GbE [8086:0000]
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe
05:00.1 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e4] (rev 11)
	DeviceName: Intel Ethernet X553 SGMII #2
	Subsystem: Intel Corporation Ethernet Connection X553 1GbE [8086:0000]
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe
06:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e5] (rev 11)
	DeviceName: Intel Ethernet X553 SGMII #3
	Subsystem: Intel Corporation Ethernet Connection X553 1GbE [8086:0000]
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe
06:00.1 Ethernet controller [0200]: Intel Corporation Ethernet Connection X553 1GbE [8086:15e5] (rev 11)
	DeviceName: Intel Ethernet X553 SGMII #4
	Subsystem: Intel Corporation Ethernet Connection X553 1GbE [8086:0000]
	Kernel driver in use: ixgbe
	Kernel modules: ixgbe
```

Note the presence of the QuickAssist co-processor:
```
> lspci -v
...
01:00.0 Co-processor: Intel Corporation Atom Processor C3000 Series QuickAssist Technology (rev 11)
	Subsystem: Intel Corporation Atom Processor C3000 Series QuickAssist Technology
	Flags: bus master, fast devsel, latency 0, IRQ 18, IOMMU group 14
	Memory at df340000 (64-bit, non-prefetchable) [size=256K]
	Memory at df300000 (64-bit, non-prefetchable) [size=256K]
	Capabilities: [b0] MSI: Enable- Count=1/1 Maskable+ 64bit+
	Capabilities: [60] MSI-X: Enable+ Count=17 Masked-
	Capabilities: [6c] Power Management version 3
	Capabilities: [74] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [138] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [140] Single Root I/O Virtualization (SR-IOV)
	Capabilities: [1b0] Access Control Services
	Kernel driver in use: c3xxx
	Kernel modules: qat_c3xxx
```

```
> grep qat /proc/crypto
driver       : qat-dh
module       : intel_qat
driver       : qat-rsa
module       : intel_qat
driver       : qat_aes_cbc_hmac_sha512
module       : intel_qat
driver       : qat_aes_cbc_hmac_sha256
module       : intel_qat
driver       : qat_aes_cbc_hmac_sha1
module       : intel_qat
driver       : qat_aes_xts
module       : intel_qat
driver       : qat_aes_ctr
module       : intel_qat
driver       : qat_aes_cbc
module       : intel_qat
```

Yet, it looks like TrueNAS Scale does not take advantage of it:

```
> cat /proc/spl/kstat/zfs/qat
cat: /proc/spl/kstat/zfs/qat: No such file or directory
```
