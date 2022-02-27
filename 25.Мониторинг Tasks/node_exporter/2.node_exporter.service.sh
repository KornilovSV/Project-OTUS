#!/bin/bash
# Make node_exporter service
#
cat node_exporter.service.unit > /etc/systemd/system/node_exporter.service
ls -l /etc/systemd/system/node*
sleep 5
systemctl daemon-reload && systemctl start node_exporter.service && \
systemctl status node_exporter.service
sleep 3
curl localhost:9100
echo  
echo # You should run the following commands on  host(s)
echo # Prometheus end Grafana:
echo # systemctl daemon-reload
echo # systemctl restart prometheus.service && systemctl status prometheus.service
echo # systemctl restart grafana-server && systemctl status grafana-server
echo #
sleep 5

