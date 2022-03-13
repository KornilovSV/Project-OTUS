#############################################################
# ELK setup Logstash
#############################################################

yum -y install logstash && \
# yum -y filebeat auditbeat metricbeat packetbeat heartbeat-elastic

# logstash config
mv /etc/logstash/logstash.yml /etc/logstash/logstash.yml.back && \
cp -iv logstash.yml /etc/logstash/logstash.yml

# sudo nano /etc/logstash/logstash.yml
# path.data: /var/lib/logstash
# path.config: /etc/logstash/conf.d
# path.logs: /var/log/logstash

# For test:
# grep ^path. /etc/logstash/logstash.yml

cp -iv logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf && \

systemctl restart logstash.service && \
clear &&  systemctl is-enabled logstash.service && \
ss -tln && sleep 7


#---------------------------------
# Filebeat config

# mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.back && \
# cp -iv filebeat.yml /etc/filebeat/filebeat.yml
# chmod 600 /etc/filebeat/filebeat.yml

# systemctl enable --now filebeat && systemctl restart filebeat && \
# clear && systemctl status filebeat && sleep 5

#END
