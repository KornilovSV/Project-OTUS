#!/bin/bash
### Install node_exporter ###

echo -n "Enter current version of Prometheus :"
read ver

---------------------------------------
### Graphana ###

# Заходим на сайт:
https://grafana.com/grafana/download?pg=get&plcmt=selfmanaged-box1-cta1
# Копируем нужную нам ссылку (Редакция должна быть OSS) в скрипт и загружаем на хост:
# 1.grafana.sh

curl -LO https://dl.grafana.com/oss/release/grafana-8.4.2-1.x86_64.rpm && \
pkg=$(ls grafana*) && yum install -y $pkg
systemctl daemon-reload && \
systemctl start grafana-server && systemctl status grafana-server

ss -tlnp

Заходим на Grafana:
http://192.168.88.102:3000/login
new password: otus-2022

Настраиваем Grafana на Prometheus:
* Configuration > Data Sources > Add data source > Prometheus
HTTP URL: http://localhost:9090

Загружаем Dashboard:
https://grafana.com/grafana/dashboards

+ > Greate > Import
Import via grafana.com:
1860 / 11074

# Или создаем свой (нужно знать синтаксис):
# + > Greate > dashboard

================================================================================
