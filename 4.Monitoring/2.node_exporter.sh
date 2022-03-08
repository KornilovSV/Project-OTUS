#!/bin/bash
### Install node_exporter ###

echo -n "Enter current version of Prometheus :"
read ver

cd ~/prometheus
curl -LO https://github.com/prometheus/node_exporter/releases/download/v$ver/node_exporter-$ver.linux-amd64.tar.gz && \
pkg=$(ls | grep tar.gz) && tar -xvf $pkg && \
useradd --no-create-home --shell /usr/sbin/nologin node_exporter && \

---
# Редактируем файл кофигурации:
nano ~/Project-OTUS/4.Monitoring/prometheus.yml
nano /etc/prometheus/prometheus.yml && \

---
systemctl restart prometheus.service && systemctl status prometheus.service & \

---
# Копируем сам node_exporter:
cp -vi ./node_exporter-$ver.linux-amd64/node_exporter /usr/local/bin/ && \
chown node_exporter: /usr/local/bin/node_exporter && \
ls -l /usr/local/bin/

---
# Создаем юнит:
cat > /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target

#; Ctrl+C

---
# Стартуем node_exporter:
systemctl daemon-reload && \
systemctl start node_exporter.service && \
systemctl status node_exporter.service

# ● node_exporter.service - Node Exporter
#   Loaded: loaded (/etc/systemd/system/node_exporter.service; disabled; vendor preset: disabled)
#   Active: active (running) since Sat 2022-02-26 01:54:52 +05; 7s ago
# Main PID: 7920 (node_exporter)

---
# Проверяем:
curl localhost:9100

# Добавляем в автозагрузку
systemctl enable node_exporter.service

---------------------------------------
