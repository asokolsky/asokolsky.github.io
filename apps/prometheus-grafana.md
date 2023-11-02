# Prometheus + Grafana on Home LAN

Here is a big picture: multiple LAN nodes will have node_exporter installed.
These are running:

* pfSense (FreeBSD)
* Linux - RHEL/CENTOS 7
* Linux - Ubuntu
* Windows 10

A server (CENTOS) will run Prometheus scraping the nodes and exposing the data
to Grafana. The same server (CENTOS) will run Grafana dashboard with cute GUI.

[Install node_exporter](prometheus/node_exporter/).

[Install Prometheus](prometheus/)

## Install Grafana on CENTOS

Let's try Grafana Enterprise:

https://grafana.com/docs/grafana/latest/installation/rpm/

Edit /etc/yum.repos.d/grafana.repo:

```
[grafana]
name=grafana
baseurl=https://packages.grafana.com/enterprise/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
```

Then `yum install grafana-enterprise`.

To start the service and verify that the service has started:

```sh
systemctl daemon-reload
systemctl start grafana-server
systemctl status grafana-server
```

Configure the Grafana server to start at boot:
```sh
systemctl enable grafana-server
```
