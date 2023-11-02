# Prometheus Install on CENTOS 8

Follow https://computingforgeeks.com/how-to-install-prometheus-on-rhel-8/

```sh
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

```sh
sudo systemctl daemon-reload
sudo systemctl start prometheus
systemctl status prometheus.service
```

Configure firewalld:

```sh
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
