#!/bin/bash
### Install node_exporter ###
# Developed by KornilovSV

echo -n "Enter current version of Node_exporter: "
read ver

cd ~/prometheus
curl -LO https://github.com/prometheus/node_exporter/releases/download/v$ver/node_exporter-$ver.linux-amd64.tar.gz && \
pkg=$(ls | grep tar.gz) && tar -xvf $pkg && \
useradd --no-create-home --shell /usr/sbin/nologin node_exporter && \

# Копируем node_exporter в /usr/local/bin:
cp -vi ./node_exporter-$ver.linux-amd64/node_exporter /usr/local/bin/ && \
chown node_exporter: /usr/local/bin/node_exporter && \
ls -l /usr/local/bin/
sleep 5

# Создаем юнит:
cp -iv ~/Git/Project-OTUS/4.Monitoring/node_exporter.service \
/etc/systemd/system/node_exporter.service && \

# Стартуем node_exporter:
systemctl daemon-reload && sleep 5 && \
systemctl start node_exporter.service && sleep 5 && \
systemctl status node_exporter.service && \
sleep 5

# Проверяем:
curl localhost:9100
sleep 3

# Добавляем в автозагрузку
systemctl enable node_exporter.service && sleep 3 &&\
clear && echo "Autostart node_exporter:"
systemctl is-enabled node_exporter.service
echo " "
ss -tln
echo " "
ip a | grep enp

# Удаляем установочный пакет
# cd ~/prometheus
rm -Rf node_exporter-1.3.1.linux-amd64 && \
rm $pkg

#END
