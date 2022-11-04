# Configure SSHD

See also [Configure SSH for Key-based Authentication](ssh.html).

## Sources

* [How to Configure the OpenSSH Server](https://www.ssh.com/academy/ssh/sshd_config)
* [Configuring Authorized Keys for OpenSSH](https://www.ssh.com/academy/ssh/authorized-keys-openssh)
* [ssh-copy-id](https://linux.die.net/man/1/ssh-copy-id)

## Installation

```sh
sudo apt-get install openssh-server -y
```

On my laptop I followed with:

```
sudo systemctl stop ssh
sudo systemctl disable ssh
sudo systemctl start ssh
```

## Configuration

My changes to `/etc/ssh/sshd_config`:

```
AddressFamily inet
LogLevel VERBOSE
```

## Add Authorized User

Enable password authentication in `/etc/ssh/sshd_config`:
```
PasswordAuthentication yes
```

Restart sshd with `sudo systemctl restart ssh`.

On a remote computer

```sh
ssh-copy-id -i ~/.ssh/id_rsa.pub alex@192.168.100.177
```

This should result in:

* a file being created `~alex/.ssh/authorized_keys`
* relevant messages in `/var/log/auth.log`.

Disable password authentication in `/etc/ssh/sshd_config`:
```
PasswordAuthentication no
```

Restart sshd with `sudo systemctl restart ssh`.
