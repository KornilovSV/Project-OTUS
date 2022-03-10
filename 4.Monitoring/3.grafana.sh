#!/bin/bash
### Install Grafana ###
# Developed by KornilovSV

cd ~/prometheus
echo -n "Enter current version of Grafana: "
read ver

curl -LO https://dl.grafana.com/oss/release/grafana-$ver.x86_64.rpm && \
pkg=$(ls grafana*) && yum install -y $pkg && \
systemctl daemon-reload && sleep 10 && \
systemctl start grafana-server && sleep 10 && clear && \
systemctl status grafana-server && systemctl enable grafana-server && \

sleep 5 && clear
curl http://localhost:3000 | head
clear && echo "Autostart grafana-server:"
systemctl is-enabled grafana-server
echo " "
ss -tln

#END
