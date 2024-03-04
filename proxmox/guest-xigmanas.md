# xigmanas guest README

## Post Install

Install the editor, and htop
```sh
sudo pkg install emacs-nox
sudo pkg install htop
```

## Guest QEMU Agent

Install the guest agent:
```sh
sudo pkg install qemu-guest-agent
```

In GUI:

System/Advanced/loader.conf add:

* `virtio_console_load`, `YES`, `for qemu-ga to work`

System/Advanced/loader.conf add

* `qemu_guest_agent_enable`, `YES`
* `qemu_guest_agent_flags`, `-d -v -l /var/log/qemu-ga.log`

Restart xigmanas, verify that the agent works:

```
xigmanas: ~# service -v qemu-guest-agent status
qemu-guest-agent is located in /usr/local/etc/rc.d
qemu_guest_agent is running as pid 3104.
```
