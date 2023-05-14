# systemctl services

This is about working with services.
[Other aspects of systemctl](cli-systemctl.html).


## Show Services

Show the running services:

```sh
systemctl list-units --type=service | grep running
```

or:
```sh
systemctl list-units --type=service --state=running
```

Show the units which failed to start:
```sh
systemctl list-units --state=failed
```

To list all the service units installed in the file system, not only the loaded:
```sh
sudo systemctl list-unit-files --type=service
```

To list only enabled service units:
```sh
systemctl list-unit-files --type=service --state=enabled
```

## Show Service Status


```sh
systemctl status _service-name_
```

## View Service Properties

```sh
systemctl show _service-name_
```

To display a single property, use the ‘-p’ flag with the property name:

```
systemctl show sshd.service -p ControlGroup

ControlGroup=/system.slice/sshd.service
```

##  View Service Dependencies

```sh
systemctl list-dependencies _service-name_
```

## Show Service Log

Use [journalctl](https://www.man7.org/linux/man-pages/man1/journalctl.1.html):

```sh
journalctl --no-pager -u _service-name_
```

## Service Management

Service actions:

* Boot-time: `enable` and `disable`, used to control the service at boot time.
* Run-time: `start`, `stop`, `restart`, and `reload`, used to control the
service on-demand.

### Start Service

```sh
sudo systemctl start _service_name_
```

### Stop Service

```sh
sudo systemctl stop _service_name_
```

### Restart Service

```sh
sudo systemctl restart UNIT_NAME.service
```

### Reload Service

You may need to reload the service while making changes to the configuration
file, which will bring up new parameters that you added.

```sh
sudo systemctl reload UNIT_NAME.service
```

### Enable the Service

To start services automatically at boot, run:

```sh
sudo systemctl enable UNIT_NAME.service
```

This will create a symlink from either
`/usr/lib/systemd/system/UNIT_NAME.service` or
`/etc/systemd/system/UNIT_NAME.service` to the
`/etc/systemd/system/SOME_TARGET.target.wants/UNIT_NAME.service`.

You can check that the service is enabled by:

```sh
systemctl is-enabled UNIT_NAME.service
```

### Disable the Service

To disable the service at boot, run:
```sh
sudo systemctl disable UNIT_NAME.service
```
This will remove the symlink that has created earlier for the service unit.


## systemd unit file

There are three main directories where unit files are stored:

* `/usr/lib/systemd/system/` - for files dropped when the package is installed;
* `/run/systemd/system/` - for files created at run time;
* `/etc/systemd/system/` - for files created by `systemctl enable` command
as well as unit files added for extending a service.


### Show the unit file

```
$ systemctl cat acpid.service
# /lib/systemd/system/acpid.service
[Unit]
Description=ACPI event daemon
Requires=acpid.socket
ConditionVirtualization=!container
Documentation=man:acpid(8)

[Service]
StandardInput=socket
EnvironmentFile=/etc/default/acpid
ExecStart=/usr/sbin/acpid $OPTIONS

[Install]
WantedBy=multi-user.target
```

### Create the unit file


https://www.2daygeek.com/linux-create-systemd-service-unit-file/


### Extending the unit file

To extend the default unit file with additional configuration options:

```sh
sudo systemctl edit _service_
```

This creates an override `/etc/systemd/system/_service_.d/override.conf` and
opens it in your text editor. Add new parameters to the unit file and the new
parameters will be added to the existing service file when the file saved.

To apply changes made to the unit:
```sh
sudo systemctl daemon-reload
```
This reloads all unit files and recreates the entire dependency tree.
To restart the service alone:
```sh
sudo systemctl restart _service_
```

## Overriding the default unit configuration

If you want to keep the changes after updating the package that provides the
unit file, edit the full unit file:

```sh
sudo systemctl edit --full _service_
```

This will load the current unit file into the editor. When the file is saved,
systemctl will create a file `/etc/systemd/system/_service_.service`.

Any unit file in `/etc/systemd/system` will override the corresponding file in
`/lib/systemd/system`.

## systemd-delta

To show all the overrides:

```sh
systemd-delta
```
