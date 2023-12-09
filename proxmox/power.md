# Proxmox Power Saving

Concepts

* [Processor P-states and C-states](https://www.thomas-krenn.com/en/wiki/Processor_P-states_and_C-states)
* [Generic Scaling Governors](https://www.kernel.org/doc/html/latest/admin-guide/pm/cpufreq.html?#generic-scaling-governors)
* [`intel_pstate` CPU Performance Scaling Driver](https://docs.kernel.org/admin-guide/pm/intel_pstate.html)
* [ASPM](https://en.wikipedia.org/wiki/Active_State_Power_Management)

Apps

* [powertop](https://linrunner.de/tlp/faq/powertop.html),
[repo](https://github.com/fenrus75/powertop)
* [cpupower](https://hreniuc.dev/how-to-use-cpupower-cpu-governors)

Install on ubuntu:
```
sudo apt install powertop linux-tools-`uname -r`
```
Install on debian:
```
sudo apt install powertop linux-cpupower
```

Info:

* [CPU frequency
scaling](https://wiki.archlinux.org/title/CPU_frequency_scaling)
* [thread1](https://forum.proxmox.com/threads/fix-always-high-cpu-frequency-in-proxmox-host.84270/)
* [thread2](https://forum.proxmox.com/threads/cpu-power-throttle-back-to-save-energy.27510/)
* [switch to acpi-cpufreq
governor](https://silvae86.github.io/2020/06/13/switching-to-acpi-power/)
* [Building a Power Efficient Home Server](https://www.youtube.com/watch?v=MucGkPUMjNo)

Just in case you have AMD CPUs:
[thread3](https://forum.level1techs.com/t/gigabyte-server-activity-corner-proxmox-docker-and-config-notes/167614).

## Monitoring

CPU frequency

```sh
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
```

better yet:
```sh
watch grep \"cpu MHz\" /proc/cpuinfo
```

## Use cpupower

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

## CPU Governor

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

### Show Scaling Driver

```sh
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
```

### Change Governor

To change governor until reboot:

```console
root@suprox:~# cpupower frequency-set -g powersave
Setting cpu: 0
Setting cpu: 1
Setting cpu: 2
Setting cpu: 3
```

To change governor permanently:

```sh
cat << 'EOF' > /etc/default/cpufrequtils
GOVERNOR="powersave"
EOF
```

## intel-pstate vs acpi-cpufreq

Is this still true? [acpi-cpufreq is
better](https://www.phoronix.com/scan.php?page=article&item=intel_pstate_linux315&num=10).
Switch the governor [to
acpi-cpufreq](https://silvae86.github.io/2020/06/13/switching-to-acpi-power/).

### Enable Power Saving Governor

To enable PowerSave (instead of Performance) governor:

```sh
echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

## Switch back to intel_pstate Governor

Ensure `intel_pstate=enable` is there for `GRUB_CMDLINE_LINUX_DEFAULT`
in `/etc/default/grub`.  Then `sudo update-grub` and reboot.

To check:

```sh
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver
```

## Enable CPU Turbo Boost

Just make sure that:

```console
root@duo:~# cat /sys/devices/system/cpu/intel_pstate/no_turbo
0
```
To change it:
```sh
echo 0 | tee /sys/devices/system/cpu/intel_pstate/no_turbo
```

If you get
`tee: /sys/devices/system/cpu/intel_pstate/no_turbo: Operation not permitted`
this means turbo is disabled in BIOS.

## Addressing `powertop` Recommendations

Create recommendation file:

```sh
sudo powertop --html
```

Add to `/etc/sysctl.conf`:

```
# recommended by powertop
kernel.nmi_watchdog=0
vm.dirty_writeback_centisecs=1500
```

Create `/etc/udev/rules.d/10-runtime-pm.rules`:

```
SUBSYSTEM!="pci", GOTO="power_runtime_rules_end"
ACTION!="add", GOTO="power_runtime_rules_end"

KERNEL=="????:??:??.?"
PROGRAM="/bin/sleep 0.1"

ATTR{power/control}=="*", ATTR{power/control}="auto"

LABEL="power_runtime_rules_end"
```

## More

Switch governor:
https://github.com/tteck/Proxmox/blob/main/misc/scaling-governor.sh
