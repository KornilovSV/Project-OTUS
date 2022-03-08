#!/bin/bash
### Install node_exporter ###

echo -n "Enter current version of Prometheus: "
read ver

cd ~/prometheus
curl -LO https://github.com/prometheus/node_exporter/releases/download/v$ver/node_exporter-$ver.linux-amd64.tar.gz && \
pkg=$(ls | grep tar.gz) && tar -xvf $pkg && \
useradd --no-create-home --shell /usr/sbin/nologin node_exporter && \

# Копируем сам node_exporter:
cp -vi ./node_exporter-$ver.linux-amd64/node_exporter /usr/local/bin/ && \
chown node_exporter: /usr/local/bin/node_exporter && \
ls -l /usr/local/bin/
sleep 5

# Создаем юнит:
cp -iv ~/Git/Project-OTUS/4.Monitoring/node_exporter.service \
/etc/systemd/system/node_exporter.service

# Стартуем node_exporter:
systemctl daemon-reload && \
systemctl start node_exporter.service && \
systemctl status node_exporter.service && \
clear && sleep 5

# Проверяем:
curl localhost:9100

# Добавляем в автозагрузку
systemctl enable node_exporter.service && sleep 3 &&\
systemctl is-enabled node_exporter.service

#END

