# Install node_exporter

## node_exporter on pfSense

Available as a module now. To verify the install point your browser to:
http://pfsense:9100/metrics

## node_exporter CENTOS 7

https://www.howtoforge.com/tutorial/how-to-install-prometheus-and-node-exporter-on-centos-7/

```sh
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xzvf node_exporter-0.18.1.linux-amd64.tar.gz
mv node_exporter-0.18.1.linux-amd64 /home/prometheus/node_exporter
```

Then sudo emacs /etc/systemd/system/node_exporter.service

```
{% include_relative node_exporter.service %}
```

Restart:
```sh
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
```
Verify its running:
```sh
sudo netstat -plntu
```

## wmi_exporter on Windows 10

Install wmi_exporter.

https://github.com/martinlindhe/wmi_exporter/releases/tag/v0.7.0

Get https://github.com/martinlindhe/wmi_exporter/releases/download/v0.7.0/wmi_exporter-0.7.0-amd64.msi
