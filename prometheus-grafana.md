# Prometheus + Grafana on Home LAN

Here is a big picture:
Multiple LAN nodes will have node_exporter installed.  These are running:

* pfSense (FreeBSD)
* Linux - RHEL/CENTOS 7
* Linux - Ubuntu
* Windows 10

A server (CENTOS) will run Prometheus scraping the nodes and exposing the data
to Grafana. The same server (CENTOS) will run Grafana dashboard with cute GUI.

## Install node_exporter

### node_exporter on pfSense

Available as a module now. To verify the install point your browser to:
http://pfsense:9100/metrics

### node_exporter CENTOS 7

https://www.howtoforge.com/tutorial/how-to-install-prometheus-and-node-exporter-on-centos-7/

```
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xzvf node_exporter-0.18.1.linux-amd64.tar.gz
mv node_exporter-0.18.1.linux-amd64 /home/prometheus/node_exporter
```

Then sudo emacs /etc/systemd/system/node_exporter.service

```
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/home/prometheus/node_exporter/node_exporter

[Install]
WantedBy=default.target
```

Restart:
```
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

sudo netstat -plntu
```

### wmi_exporter on Windows 10

Install wmi_exporter.

https://github.com/martinlindhe/wmi_exporter/releases/tag/v0.7.0

Get https://github.com/martinlindhe/wmi_exporter/releases/download/v0.7.0/wmi_exporter-0.7.0-amd64.msi

Install Prometheus

## Prometheus on CENTOS 8

Follow https://computingforgeeks.com/how-to-install-prometheus-on-rhel-8/

```
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
sudo mkdir /var/lib/prometheus
for i in rules rules.d files_sd; do
  sudo mkdir -p /etc/prometheus/${i};
done
cd /tmp
export RELEASE=2.10.0
wget https://github.com/prometheus/prometheus/releases/download/v${RELEASE}/prometheus-${RELEASE}.linux-amd64.tar.gz
tar xvf prometheus-${RELEASE}.linux-amd64.tar.gz
cd prometheus-${RELEASE}.linux-amd64/
sudo cp prometheus promtool /usr/local/bin/
sudo cp -r consoles/ console_libraries/ /etc/prometheus/
```

Edit sudo emacs /etc/prometheus/prometheus.yml

```
# Global config
global:
  scrape_interval:     15s # Default is every 1 minute.
  evaluation_interval: 15s # The default is every 1 minute.
  scrape_timeout: 15s  # scrape_timeout is set to the global default (10s).

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']

sudo vim /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
Environment="GOMAXPROCS=2"
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
```

Set directory permissions:

```
for i in rules rules.d files_sd; do
  sudo chown -R prometheus:prometheus /etc/prometheus/${i};
done
for i in rules rules.d files_sd; do
  sudo chmod -R 775 /etc/prometheus/${i};
done
sudo chown -R prometheus:prometheus /var/lib/prometheus/
```

Start Prometheus service:

```
sudo systemctl daemon-reload
sudo systemctl start prometheus
systemctl status prometheus.service
```

Configure firewalld:

```
sudo firewall-cmd --permanent --add-rich-rule \
  'rule family="ipv4" source address="192.168.1.0/24" port protocol="tcp" port="9090" accept'
sudo firewall-cmd --reload
```

Verify the install by pointing the browser to http://localhost:9090/

To add targets: sudo emacs /etc/prometheus/prometheus.yml

```
  targets: ['localhost:9090', '192.168.1.1:9100']
```
Then restart prometheus:

```
sudo systemctl restart prometheus
```

## Install Grafana

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

```
systemctl daemon-reload
systemctl start grafana-server
systemctl status grafana-server
```

Configure the Grafana server to start at boot: `systemctl enable grafana-server`
