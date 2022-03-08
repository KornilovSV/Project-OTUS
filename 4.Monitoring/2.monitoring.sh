#!/bin/bash
### Prometheus ###

# Заходим на сайт (в браузере)
# https://github.com/prometheus/prometheus/releases/

# Находим последнюю версию:
# Ctrl+F linux-amd64.tar.gz
# копируем ссылку в скрипт и загружаем на хост:


# 1.prometheus_get
mkdir ~/prometheus && cd ~/prometheus && \
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.33.4/prometheus-2.33.4.linux-amd64.tar.gz && \
pkg=$(ls | grep tar.gz) && tar -xvf $pkg && \
mkdir {/etc/,/var/lib/}prometheus && \
useradd --no-create-home --shell /usr/sbin/nologin prometheus && \
cd ~/prometheus/prometheus-2.33.4.linux-amd64 && \
cp -iv prom{etheus,tool} /usr/local/bin/ && \
cp -riv {console{s,_libraries},prometheus.yml} /etc/prometheus/ && \
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/

## ---
## Запускаем prometheus в ручную:
## sudo -u prometheus /usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries
#; Ctrl+C

# В другой консоли смотрим открытый порт 9090:
ss -tlnp
sleep 5
# В браузере подключаемся к prometheus:
clear && sleep 5
curl http://192.168.4.42:9090 | head
sleep 5

-------------------------
# Создаем юнит в systemd
cp -iv ~/Git/Project-OTUS/4.Monitoring/prometheus.service > \
/etc/systemd/system/prometheus.service

#; Ctrl+C
---
# Запускаем prometheus:
systemctl daemon-reload && systemctl start prometheus.service && \
clear && systemctl status prometheus.service && \
sleep 5

# Добавляем в автозагрузку
systemctl enable prometheus.service

# Удаляем установочный пакет
cd ~/prometheus
rm $pkg

---------------------------------------
### node_exporter ###

#Заходим на сайт:
# https://github.com/prometheus/node_exporter/releases/
#Находим последнюю версию:
# Ctrl+F linux-amd64.tar.gz

# Копируем ссылку в скрипт и загружаем на хост:
# 1.node_exporter.sh

cd ~/prometheus
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz && \
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
cp -vi ./node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/ && \
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
### Graphana ###

# Заходим на сайт:
https://grafana.com/grafana/download?pg=get&plcmt=selfmanaged-box1-cta1
# Копируем нужную нам ссылку (Редакция должна быть OSS) в скрипт и загружаем на хост:
# 1.grafana.sh

curl -LO https://dl.grafana.com/oss/release/grafana-8.4.2-1.x86_64.rpm && \
pkg=$(ls grafana*) && yum install -y $pkg
systemctl daemon-reload && \
systemctl start grafana-server && systemctl status grafana-server

# ● grafana-server.service - Grafana instance
#   Loaded: loaded (/usr/lib/systemd/system/grafana-server.service; disabled; vendor preset: disabled)
#   Active: active (running) since Sat 2022-02-26 10:04:34 +05; 10s ago
#     Docs: http://docs.grafana.org
# Main PID: 8350 (grafana-server)

# Смотрим, что порты 3000 (grafana), 9090 (prometheus), 9100 (node_exporter) доступны:
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
# Разное:

https://github.com/blackden/prometheus_node_grafana/
https://wiki.gentoo.org/wiki/Keychain/ru
https://wiki.gentoo.org/wiki/Keychain/ru#.D0.92.D1.8B.D0.B6.D0.B8.D0.BC.D0.B0.D0.BD.D0.B8.D0.B5_.D0.BF.D0.BE.D1.81.D0.BB.D0.B5.D0.B4.D0.BD.D0.B5.D0.B9_.D0.BA.D0.B0.D0.BF.D0.BB.D0.B8_.D1.83.D0.B4.D0.BE.D0.B1.D1.81.D1.82.D0.B2.D0.B0_.D0.B8.D0.B7_ssh-agent

12:28:50 От Денис Федоров до Все:
--------------------------
По SNMP для RouterOS, etc:
	https://github.com/prometheus/snmp_exporter

curl -LO https://github.com/prometheus/snmp_exporter/releases/download/v0.20.0/snmp_exporter-0.20.0.linux-mips64.tar.gz
pkg=$(ls snmp*) && tar -xvf $pkg

cp ./snmp_exporter-0.20.0.linux-mips64/snmp_exporter /usr/local/bin/snmp_exporter
chown node_exporter: /usr/local/bin/snmp_exporter

---
cat > /etc/systemd/system/snmp_exporter.service
[Unit]
Description=SNMP Exporter
After=network-online.target

[Service]
User=pi
Restart=on-failure
ExecStart=/usr/local/bin/snmp_exporter --config.file='/etc/prometheus/snmp.yml'

[Install]
WantedBy=multi-user.target
----------------------------------

12:43:04 От Денис Федоров до Все:
	https://otus.ru/polls/33117/
 
 #END
 
