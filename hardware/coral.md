# Coral Edge TPU

[M.2 Accelerator B+M key](https://coral.ai/products/m2-accelerator-bm),
[datasheet](https://www.mouser.com/datasheet/2/963/Coral_M2_datasheet-3237151.pdf).

After installing, presents itself as a PCI device
```
03:00.0 System peripheral: Global Unichip Corp. Coral Edge TPU
```

Checkl secure boot status:
```
> mokutil --sb-state
SecureBoot disabled
```

Instruction for
[driver installation](https://coral.ai/docs/m2/get-started/#2a-on-linux) are
[broken for kernel 6.5](https://github.com/google-coral/edgetpu/issues/808).

Had to build the driver locally:

```sh
git clone https://github.com/google/gasket-driver.git
cd gasket-driver/
debuild -us -uc -tc -b
```

Ignore the lint error message.

```sh
cd ..
sudo dpkg -i gasket-dkms_1.0-18_all.deb
```

Reboot, verify success:

```
# lspci -nn | grep 089a
03:00.0 System peripheral [0880]: Global Unichip Corp. Coral Edge TPU [1ac1:089a]
# ls -al /dev/apex*
crw-rw---- 1 root root 120, 0 Jan  2 13:52 /dev/apex_0
root@exi:/home/alex#
```
