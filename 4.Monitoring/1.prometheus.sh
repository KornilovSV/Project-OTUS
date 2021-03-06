#!/bin/bash
### Install Prometheus ###
# Developed by KornilovSV

echo -n "Enter current version of Prometheus (example 2.34.0): "
read ver

mkdir ~/prometheus && cd ~/prometheus && \
curl -LO https://github.com/prometheus/prometheus/releases/download/v$ver/prometheus-$ver.linux-amd64.tar.gz && \
pkg=$(ls | grep tar.gz) && tar -xvf $pkg && \
mkdir {/etc/,/var/lib/}prometheus && \
useradd --no-create-home --shell /usr/sbin/nologin prometheus && \
cd ~/prometheus/prometheus-$ver.linux-amd64 && \
cp -iv prom{etheus,tool} /usr/local/bin/ && \
cp -riv {console{s,_libraries},prometheus.yml} /etc/prometheus/ && \
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/

## ---
# echo "В другой консоли в браузере подключаемся к prometheus: "
# echo "http://host-IP:9090"

## Запускаем prometheus в ручную (если необходимо):
## sudo -u prometheus /usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
#; Ctrl+C

## -------------------------
# Создаем юнит в systemd
cp -iv ~/Git/Project-OTUS/4.Monitoring/prometheus.service /etc/systemd/system/prometheus.service && \
systemctl daemon-reload && \

# Копируем настройки prometheus.yum
mv -fv /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml.back && \
cp -iv ~/Git/Project-OTUS/4.Monitoring/prometheus.yml /etc/prometheus/prometheus.yml && \
sleep 5 && \

# Проверяем конфигурацию prometheus
clear && echo "Checking the syntax: "
promtool check config /etc/prometheus/prometheus.yml
echo " " && sleep 5 && \

# Запускаем prometheus:
systemctl start prometheus.service && \
clear && systemctl status prometheus.service && \
sleep 5

# Добавляем в автозагрузку
systemctl enable prometheus.service && \
clear && echo "Autostart prometheus:"
systemctl is-enabled prometheus.service

echo " "
ss -tln
echo " "
echo "If necessary, change the IP address or add monitoring hosts in: "
echo "/etc/prometheus/prometheus.yml"
cat /etc/prometheus/prometheus.yml | grep -A7 node_exporter
# sleep 5

# Удаляем установочный пакет
cd ~/prometheus
rm -f $pkg

# END

