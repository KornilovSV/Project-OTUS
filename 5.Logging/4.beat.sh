#############################################################
# ELK setup Beats
#############################################################

yum -y filebeat auditbeat metricbeat packetbeat heartbeat-elastic

# Filebeat config
mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.back && \
cp -iv filebeat.yml /etc/filebeat/filebeat.yml
chmod 600 /etc/filebeat/filebeat.yml

# Start Filebeat
systemctl enable --now filebeat && sleep 5 && \
systemctl restart filebeat && \
clear && systemctl status filebeat && sleep 5

#END
