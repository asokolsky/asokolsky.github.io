# Proxmox Power Saving

## Sources

https://wiki.archlinux.org/title/CPU_frequency_scaling
https://forum.proxmox.com/threads/fix-always-high-cpu-frequency-in-proxmox-host.84270/
https://forum.proxmox.com/threads/cpu-power-throttle-back-to-save-energy.27510/

The problem statement here is relevant for AMD CPUs:
https://forum.level1techs.com/t/gigabyte-server-activity-corner-proxmox-docker-and-config-notes/167614


## Enable Power Saving

To enable powersave (instead of Performance) governor:

```
% echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

To monitor CPU frequency:

```
% cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
```

## Enable CPU Turbo Boost

More on these utilities:
https://www.hreniuc.dev/2019/03/28/how-to-use-cpupower-cpu-governors/

```
% cpupower
WARNING: cpupower not found for kernel 5.4.0-66

  You may need to install the following packages for this specific kernel:
    linux-tools-5.4.0-66-generic
    linux-cloud-tools-5.4.0-66-generic

  You may also want to install one of the following packages to keep up to date:
    linux-tools-generic
    linux-cloud-tools-generic

% sudo apt install linux-tools-common
```
or
```
% apt install linux-cpupower cpufrequtils
```

Then
```
root@fuji:~# cpupower frequency-info
analyzing CPU 0:
  driver: intel_pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 800 MHz - 3.90 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 800 MHz and 3.90 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 3.90 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
```

Just make sure that:

```
root@duo:~# cat /sys/devices/system/cpu/intel_pstate/no_turbo
0
```

To change governor:

```
root@suprox:~# cpupower frequency-set -g powersave
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3
```
