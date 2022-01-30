# API Umbrella on CentOS7

Big picture:
https://github.com/NREL/api-umbrella/wiki/Deployment


## Install

Follow instructions from https://apiumbrella.io/install/

```
[alex@localhost tmp]$ curl https://bintray.com/nrel/api-umbrella-el7/rpm | sudo tee /etc/yum.repos.d/api-umbrella.repo
[alex@localhost tmp]$ sudo yum install api-umbrella

Dependencies Resolved

===========================================================================================================================================
 Package                               Arch             Version                             Repository                                Size
===========================================================================================================================================
Installing:
 api-umbrella                          x86_64           0.15.1-1.el7                        bintray--nrel-api-umbrella-el7           151 M
Installing for dependencies:
 copy-jdk-configs                      noarch           3.3-10.el7_5                        base                                      21 k
 java-1.8.0-openjdk-headless           x86_64           1:1.8.0.262.b10-0.el7_8             updates                                   33 M
 javapackages-tools                    noarch           3.4.1-11.el7                        base                                      73 k
 libgcrypt-devel                       x86_64           1.5.3-14.el7                        base                                     129 k
 libgpg-error-devel                    x86_64           1.12-3.el7                          base                                      16 k
 libxml2-devel                         x86_64           2.9.1-6.el7.4                       base                                     1.0 M
 libxslt                               x86_64           1.1.28-5.el7                        base                                     242 k
 libxslt-devel                         x86_64           1.1.28-5.el7                        base                                     309 k
 libyaml                               x86_64           0.1.4-11.el7_0                      base                                      55 k
 lksctp-tools                          x86_64           1.0.17-2.el7                        base                                      88 k
 pcsc-lite-libs                        x86_64           1.8.8-8.el7                         base                                      34 k
 python-javapackages                   noarch           3.4.1-11.el7                        base                                      31 k
 python-lxml                           x86_64           3.2.1-4.el7                         base                                     758 k
 tcl                                   x86_64           1:8.5.13-8.el7                      base                                     1.9 M
 tzdata-java                           noarch           2020a-1.el7                         updates                                  188 k
 xz-devel                              x86_64           5.2.2-1.el7                         base                                      46 k

Transaction Summary
===========================================================================================================================================
Install  1 Package (+16 Dependent packages)

Total download size: 189 M
Installed size: 820 M
Is this ok [y/d/N]: y
...
Installed:
  api-umbrella.x86_64 0:0.15.1-1.el7

Dependency Installed:
  copy-jdk-configs.noarch 0:3.3-10.el7_5      java-1.8.0-openjdk-headless.x86_64 1:1.8.0.262.b10-0.el7_8      javapackages-tools.noarch 0:3.4.1-11.el7
  libgcrypt-devel.x86_64 0:1.5.3-14.el7       libgpg-error-devel.x86_64 0:1.12-3.el7                          libxml2-devel.x86_64 0:2.9.1-6.el7.4
  libxslt.x86_64 0:1.1.28-5.el7               libxslt-devel.x86_64 0:1.1.28-5.el7                             libyaml.x86_64 0:0.1.4-11.el7_0
  lksctp-tools.x86_64 0:1.0.17-2.el7          pcsc-lite-libs.x86_64 0:1.8.8-8.el7                             python-javapackages.noarch 0:3.4.1-11.el7
  python-lxml.x86_64 0:3.2.1-4.el7            tcl.x86_64 1:8.5.13-8.el7                                       tzdata-java.noarch 0:2020a-1.el7
  xz-devel.x86_64 0:5.2.2-1.el7

Complete!

[alex@localhost tmp]$ sudo /etc/init.d/api-umbrella start
Starting api-umbrella (via systemctl):                     [  OK  ]
```

## Configuration

It seems that out of the box api-umbrella runs on localhost only.

```
[root@localhost init.d]# sudo /etc/init.d/api-umbrella stop
Stopping api-umbrella (via systemctl):  ^[[60G[  OK  ]
[root@localhost init.d]# ss -4nlp
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
udp    UNCONN     0      0         *:68                    *:*                   users:(("dhclient",pid=781,fd=6))
udp    UNCONN     0      0      127.0.0.1:323                   *:*                   users:(("chronyd",pid=630,fd=5))
tcp    LISTEN     0      128       *:22                    *:*                   users:(("sshd",pid=971,fd=3))
tcp    LISTEN     0      100    127.0.0.1:25                    *:*                   users:(("master",pid=1412,fd=13))
[root@localhost init.d]# sudo /etc/init.d/api-umbrella start
Starting api-umbrella (via systemctl):  ^[[60G[  OK  ]
[root@localhost init.d]# ss -4nlp
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
udp    UNCONN     0      0         *:68                    *:*                   users:(("dhclient",pid=781,fd=6))
udp    UNCONN     0      0      127.0.0.1:323                   *:*                   users:(("chronyd",pid=630,fd=5))
tcp    LISTEN     0      128    127.0.0.1:14004                 *:*                   users:(("mora",pid=2454,fd=3))
tcp    LISTEN     0      128       *:22                    *:*                   users:(("sshd",pid=971,fd=3))
tcp    LISTEN     0      128    127.0.0.1:14009                 *:*                   users:(("[TS_MAIN]",pid=2588,fd=7),("traffic_manager",pid=2460,fd=7))
tcp    LISTEN     0      100    127.0.0.1:25                    *:*                   users:(("master",pid=1412,fd=13))
tcp    LISTEN     0      128    127.0.0.1:14010                 *:*                   users:(("nginx",pid=2524,fd=4),("nginx",pid=2523,fd=4),("nginx",pid=2456,fd=4))
tcp    LISTEN     0      128       *:443                   *:*                   users:(("nginx",pid=2524,fd=6),("nginx",pid=2523,fd=6),("nginx",pid=2456,fd=6))
tcp    LISTEN     0      128    127.0.0.1:14012                 *:*                   users:(("nginx",pid=2524,fd=9),("nginx",pid=2523,fd=9),("nginx",pid=2456,fd=9))
tcp    LISTEN     0      128    127.0.0.1:14013                 *:*                   users:(("nginx",pid=2524,fd=10),("nginx",pid=2523,fd=10),("nginx",pid=2456,fd=10))
tcp    LISTEN     0      55     127.0.0.1:14014                 *:*                   users:(("rsyslogd",pid=2458,fd=4))
tcp    LISTEN     0      128       *:80                    *:*                   users:(("nginx",pid=2524,fd=5),("nginx",pid=2523,fd=5),("nginx",pid=2456,fd=5))
tcp    LISTEN     0      128    127.0.0.1:14001                 *:*                   users:(("mongod",pid=2452,fd=5))
```

System configuration is done via /etc/api-umbrella/api-umbrella.yml and is described
in few sections starting here: https://api-umbrella.readthedocs.io/en/latest/server/admin-auth.html

```
[root@localhost init.d]# sudo /etc/init.d/api-umbrella stop
Stopping api-umbrella (via systemctl):  ^[[60G[  OK  ]
[root@localhost init.d]# cat /etc/api-umbrella/api-umbrella.yml
http_port: 8080
https_port: 8443
services:
  - general_db
  - log_db
  - router
  - web
web:
  admin:
    initial_superusers:
      - alex
    auth_strategies:
      enabled:
        - local
    username_is_email: false
    password_length_min: 4
    password_length_max: 72
elasticsearch:
  hosts:
    - http://127.0.0.1:14002
mongodb:
  url: mongodb://127.0.0.1:14001/api_umbrella
nginx:
  workers: 4
gatekeeper:
  workers: 4
[root@localhost init.d]# sudo /etc/init.d/api-umbrella start
Starting api-umbrella (via systemctl):  ^[[60G[  OK  ]
[root@localhost init.d]# ss -4nlp
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
udp    UNCONN     0      0         *:68                    *:*                   users:(("dhclient",pid=781,fd=6))
udp    UNCONN     0      0      127.0.0.1:323                   *:*                   users:(("chronyd",pid=630,fd=5))
tcp    LISTEN     0      128    127.0.0.1:14004                 *:*                   users:(("mora",pid=2869,fd=3))
tcp    LISTEN     0      128       *:22                    *:*                   users:(("sshd",pid=971,fd=3))
tcp    LISTEN     0      128    127.0.0.1:14009                 *:*                   users:(("[TS_MAIN]",pid=3018,fd=7),("traffic_manager",pid=2875,fd=7))
tcp    LISTEN     0      100    127.0.0.1:25                    *:*                   users:(("master",pid=1412,fd=13))
tcp    LISTEN     0      128    127.0.0.1:14010                 *:*                   users:(("nginx",pid=2934,fd=4),("nginx",pid=2933,fd=4),("nginx",pid=2932,fd=4),("nginx",pid=2931,fd=4),("nginx",pid=2871,fd=4))
tcp    LISTEN     0      128       *:8443                  *:*                   users:(("nginx",pid=2934,fd=6),("nginx",pid=2933,fd=6),("nginx",pid=2932,fd=6),("nginx",pid=2931,fd=6),("nginx",pid=2871,fd=6))
tcp    LISTEN     0      128    127.0.0.1:14012                 *:*                   users:(("nginx",pid=2934,fd=9),("nginx",pid=2933,fd=9),("nginx",pid=2932,fd=9),("nginx",pid=2931,fd=9),("nginx",pid=2871,fd=9))
tcp    LISTEN     0      128    127.0.0.1:14013                 *:*                   users:(("nginx",pid=2934,fd=10),("nginx",pid=2933,fd=10),("nginx",pid=2932,fd=10),("nginx",pid=2931,fd=10),("nginx",pid=2871,fd=10))
tcp    LISTEN     0      55     127.0.0.1:14014                 *:*                   users:(("rsyslogd",pid=2873,fd=4))
tcp    LISTEN     0      128       *:8080                  *:*                   users:(("nginx",pid=2934,fd=5),("nginx",pid=2933,fd=5),("nginx",pid=2932,fd=5),("nginx",pid=2931,fd=5),("nginx",pid=2871,fd=5))
tcp    LISTEN     0      128    127.0.0.1:14001                 *:*                   users:(("mongod",pid=2867,fd=5))
```

Even after this http://192.168.1.151:8080 or https://192.168.1.151:8443 are not responding - turning firewall off helped.

## Use

### Admin Login

Various admin authentication mechanisms are
[supported](https://api-umbrella.readthedocs.io/en/latest/server/admin-auth.html).

My server is deployed on a LAN with no public IP. Local authentication with an
account in initial_superusers did not work as expected.

### API Key Signup

The outcome of the signup is:

```
API Key Signup

Your API key for asokolsky@gmail.com is:
e93CdhL6iHAJlrLgWAuEFjMCg3PAm5SwPnhDpKIj

You can start using this key to make web service requests. Simply pass your key in the URL when making a web request. Here's an example:

/example.json?api_key=e93CdhL6iHAJlrLgWAuEFjMCg3PAm5SwPnhDpKIj
```
