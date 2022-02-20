# Proxmox Power Saving

## Sources

* [CPU frequency
scaling](https://wiki.archlinux.org/title/CPU_frequency_scaling)
* [thread1](https://forum.proxmox.com/threads/fix-always-high-cpu-frequency-in-proxmox-host.84270/)
* [thread2](https://forum.proxmox.com/threads/cpu-power-throttle-back-to-save-energy.27510/)
* https://silvae86.github.io/2020/06/13/switching-to-acpi-power/

Just in case you have AMD CPUs:
[thread3](https://forum.level1techs.com/t/gigabyte-server-activity-corner-proxmox-docker-and-config-notes/167614).

## Monitor CPU frequency

```console
% cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
```

better yet:
```console
watch grep \"cpu MHz\" /proc/cpuinfo
```

## Enable Power Saving

To enable powersave (instead of Performance) governor:

```console
% echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

## Enable CPU Turbo Boost

More on these utilities:
https://www.hreniuc.dev/2019/03/28/how-to-use-cpupower-cpu-governors/

```console
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
```console
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

[About
governors](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/power_management_guide/cpufreq_governors):

* cpufreq_performance - offers no power saving benefit;
* cpufreq_powersave - forces the CPU to use the lowest possible clock frequency,
this frequency will be statically set, and will not change. This is more of a
speed limiter than a power saver.
* cpufreq_ondemand - a dynamic governor that allows the CPU to achieve maximum
clock frequency when system load is high, and also minimum clock frequency when
the system is idle.
* cpufreq_conservative - like the ondemand governor, adjusts the frequency,
however more gradually.
* cpufreq_userspace - allows userspace programs to set the frequency, used
with the cpuspeed daemon.


Just make sure that:

```console
root@duo:~# cat /sys/devices/system/cpu/intel_pstate/no_turbo
0
```

To change governor:

```console
root@suprox:~# cpupower frequency-set -g powersave
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3
```

## intel-pstate vs acpi-cpufreq

Apparently [acpi-cpufreq is
better](https://www.phoronix.com/scan.php?page=article&item=intel_pstate_linux315&num=10).

Switch the governor [to acpi-cpufreq](https://silvae86.github.io/2020/06/13/switching-to-acpi-power/).
