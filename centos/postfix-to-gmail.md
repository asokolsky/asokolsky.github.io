# Portfix to Gmail Config

The purpose of this is to allow for the e-mail to be delivered from HomeLAN CentOS7 server to my gmail account.

Instructions: 
https://devops.ionos.com/tutorials/configure-a-postfix-relay-through-gmail-on-centos-7/

## Installation

Only mailx was not there:

```
[root@centos7 api-umbrella]# yum -y install postfix cyrus-sasl-plain mailx
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
epel/x86_64/metalink                                     | 9.2 kB     00:00
 * base: mirror.cs.uwp.edu
 * epel: mirrors.xmission.com
 * extras: mirror.xrepo.net
 * updates: mirrors.radwebhosting.com
base                                                     | 3.6 kB     00:00
bintray--nrel-api-umbrella-el7                           | 1.3 kB     00:00
epel                                                     | 4.7 kB     00:00
extras                                                   | 2.9 kB     00:00
updates                                                  | 2.9 kB     00:00
(1/2): epel/x86_64/updateinfo                              | 1.0 MB   00:00
(2/2): epel/x86_64/primary_db                              | 6.9 MB   00:00
Package 2:postfix-2.10.1-9.el7.x86_64 already installed and latest version
Package cyrus-sasl-plain-2.1.26-23.el7.x86_64 already installed and latest version
Resolving Dependencies
--> Running transaction check
---> Package mailx.x86_64 0:12.5-19.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package         Arch             Version                  Repository      Size
================================================================================
Installing:
 mailx           x86_64           12.5-19.el7              base           245 k

Transaction Summary
================================================================================
Install  1 Package

Total download size: 245 k
Installed size: 466 k
Downloading packages:
mailx-12.5-19.el7.x86_64.rpm                               | 245 kB   00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : mailx-12.5-19.el7.x86_64                                     1/1
  Verifying  : mailx-12.5-19.el7.x86_64                                     1/1

Installed:
  mailx.x86_64 0:12.5-19.el7

Complete!

[root@centos7 api-umbrella]# systemctl restart postfix
[root@centos7 api-umbrella]# systemctl enable postfix
```

## Configure Postfix

Just follow the instructions above.

## Test the Relay

Just follow the instructions above.
