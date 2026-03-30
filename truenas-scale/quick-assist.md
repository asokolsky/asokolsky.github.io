# TrueNAS Scale and Quick Assist

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

The corresponding device is available:

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

For more, see this [gist](https://gist.github.com/arakashic/e06b84c2806adb5bd4c7638189cd4c4c) and [notes](https://forums.truenas.com/t/notes-on-enabling-intel-qat-for-zfs-in-truenas/39740)
