# TrueNAS Customization

## TrueNAS Core: Facilitate Troubleshooting

For SMB, here is [a
guide](https://www.truenas.com/community/threads/solved-freenas-8-3-0-log-users-activity-with-full_audit-vfs-object.10076/).
In Sharing / SMB / Share/ Auxiliary Parameters:

```
vfs objects = full_audit
full_audit:prefix = %u|%I|%S
full_audit:failure = connect
full_audit:success = connect disconnect opendir mkdir rmdir closedir open close read pread write pwrite sendfile rename unlink chmod fchmod chown fchown chdir ftruncate lock symlink readlink link mknod realpath
full_audit:facility = LOCAL5
full_audit:priority = NOTICE
```

## Drive Spin Down

https://github.com/ngandrass/truenas-spindown-timer

## TrueNAS Scale: enable apt for package management

```sh
sudo chmod a+x /usr/bin/apt*
sudo chmod a+x /usr/bin/dpkg
```

Before you install new packages, do:

```sh
sudo apt update
```

Then install packages as usual:
```sh
sudo apt install emacs-nox
```

## Setting up TrueNAS Scale for VMs

[video](https://www.youtube.com/watch?v=R7BXEuKjJ0k),
[post](https://forum.level1techs.com/t/truenas-scale-ultimate-home-setup-incl-tailscale/186444)
