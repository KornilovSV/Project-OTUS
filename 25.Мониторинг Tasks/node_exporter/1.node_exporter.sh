#!/bin/bash
# Get node_exporter:
#
cd ~/prometheus/ && \
#curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz && \
# sleep 2 && pkg=$(ls node*) && \
# sleep 2 tar -xf $pkg && \
# useradd --no-create-home --shell /usr/sbin/nologin node_exporter && \
cp -vi ./node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/ && \
chown node_exporter: /usr/local/bin/node_exporter && \
ls -l /usr/local/bin/
