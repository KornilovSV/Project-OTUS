#!/bin/bash
### Install Grafana ###
# Developed by KornilovSV

cd ~/prometheus
echo -n "Enter current version of Grafana (example 8.4.4-1): "
read ver

curl -LO https://dl.grafana.com/oss/release/grafana-$ver.x86_64.rpm && \
pkg=$(ls grafana*) && yum install -y $pkg && \

echo "Start Grafana"
systemctl daemon-reload && sleep 10 && \
systemctl enable grafana-server && \
systemctl start grafana-server && \
clear && systemctl status grafana-server && \

sleep 5 && clear
curl http://localhost:3000 | head
clear && echo "Autostart grafana-server:"
systemctl is-enabled grafana-server
echo " "
ss -tln

#END
