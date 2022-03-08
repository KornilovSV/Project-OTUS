#!/bin/bash
### Install Grafana ###

cd ~/prometheus
echo -n "Enter current version of Grafana: "
read ver

curl -LO https://dl.grafana.com/oss/release/grafana-$ver.x86_64.rpm && \
pkg=$(ls grafana*) && yum install -y $pkg
systemctl daemon-reload && \
systemctl start grafana-server && systemctl status grafana-server

sleep 3 && clear
curl http://localhost:3000 | head
echo " "
ss -tln

#END

