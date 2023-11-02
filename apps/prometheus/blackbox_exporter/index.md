# Prometheus Blackbox Exporter

https://github.com/prometheus/blackbox_exporter


```sh
docker run --rm --network ip6net -p 9115:9115/tcp --name blackbox_exporter \
    -v `pwd`/config:/config \
    quay.io/prometheus/blackbox-exporter:latest \
    --config.file=/config/blackbox.yml
```

where `config/blackbox.yml` is:
```yaml
{% include_relative blackbox.yml %}
```
