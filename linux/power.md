# Linux (Laptop) Power Saving

For server see [Proxmox Power Saving](/proxmox/power.html).

Concepts

* [Processor P-states and C-states](https://www.thomas-krenn.com/en/wiki/Processor_P-states_and_C-states)
* [Generic Scaling Governors](https://www.kernel.org/doc/html/latest/admin-guide/pm/cpufreq.html?#generic-scaling-governors)
* [`intel_pstate` CPU Performance Scaling Driver](https://docs.kernel.org/admin-guide/pm/intel_pstate.html)
* [ASPM](https://en.wikipedia.org/wiki/Active_State_Power_Management)

[Tips to Extend Laptop Battery Life](https://www.youtube.com/watch?v=kTFnGwW2e_Y)
and accompanying
[laptop-power-management](https://christitus.com/laptop-power-management/)

## Apps

* powertop [repo](https://github.com/fenrus75/powertop),
[faq](https://linrunner.de/tlp/faq/powertop.html).
* [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq)

### powertop

Install:
```sh
sudo apt install powertop
```
Run:
```sh
sudo powertop
```
### auto-cpufreq

Install it:
```sh
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
```

## ASPM support

Check for the status of the [ASPM](https://en.wikipedia.org/wiki/Active_State_Power_Management) support:
```sh
sudo lspci -vv | awk '/ASPM/{print $0}' RS= | grep --color -P '(^[a-z0-9:.]+|ASPM )'
```

Enable [auto-aspm script](https://github.com/notthebee/autoaspm).
