# Installing Prometheus, Victoriametrics, Grafana

## Install Prometheus with node_exporter

For CENTOS7
https://www.fosslinux.com/10398/how-to-install-and-configure-prometheus-on-centos-7.htm

For CENTOS8
https://www.linuxtechi.com/install-prometheus-monitoring-tool-centos-8-rhel-8/
or
https://computingforgeeks.com/how-to-install-prometheus-on-rhel-8/

node_exporter metrics are at: http://graf:9100/metrics

prometheus metrics are at: http://graf:9090/metrics

Inpect your prometheus targets by pointing web browser to:
http://graf:9090/targets


## Install VictoriaMetrics

Follow steps here
https://copr.fedorainfracloud.org/coprs/antonpatsev/VictoriaMetrics/

VictoriMetrics exposes its own metrics at
http://graf:8428/metrics

## Install Grafana

For CENTOS7 https://www.fosslinux.com/8328/how-to-install-and-configure-grafana-on-centos-7.htm

For CENTOS8: https://computingforgeeks.com/how-to-install-grafana-on-rhel-8/

Grafana exposes its own metrics at
http://graf:3000/metrics

## More Prometheus Exporters

https://prometheus.io/docs/instrumenting/exporters/
