# NVIDIA GPU

https://forums.developer.nvidia.com/t/rtx-3050-idle-power-too-high/310255


## Driver

To check the driver used:

```sh
inxi -Gx
```

## nvidia-smi

[man page](https://docs.nvidia.com/deploy/nvidia-smi/),
[cheat sheet](https://www.seimaxim.com/kb/gpu/nvidia-smi-cheat-sheet).

```
alex@exi > ~/Projects/asokolsky.github.io > main ± > nvidia-smi
Sun Apr 20 11:50:26 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.163.01             Driver Version: 550.163.01     CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 3050        Off |   00000000:01:00.0  On |                  N/A |
|  0%   44C    P3             25W /  130W |     520MiB /   8192MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      1354      G   /usr/lib/xorg/Xorg                            226MiB |
|    0   N/A  N/A      2296      G   cinnamon                                       37MiB |
|    0   N/A  N/A      2644      G   ...erProcess --variations-seed-version        110MiB |
|    0   N/A  N/A      3066      G   /usr/lib/firefox/firefox                      131MiB |
+-----------------------------------------------------------------------------------------+
```

## Driver/library version mismatch

```
alex@exi > ~/Downloads > nvidia-smi
Failed to initialize NVML: Driver/library version mismatch
alex@exi > ~/Downloads > cat /proc/driver/nvidia/version
NVRM version: NVIDIA UNIX x86_64 Kernel Module  550.144.03  Mon Dec 30 17:44:08 UTC 2024
GCC version:  gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)
```

reboot helped
