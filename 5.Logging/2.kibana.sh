#############################################################
# ELK setup Kibana
#############################################################

yum -y install kibana && \

# Конфигурация kibana:
mv /etc/kibana/kibana.yml /etc/kibana/kibana.yml.back && \
cp -iv kibana.yml /etc/kibana/kibana.yml && \
chmod 660 /etc/kibana/kibana.yml && chgrp kibana /etc/kibana/kibana.yml && \

# ---
# sudo nano /etc/kibana/kibana.yml
# server.port: 5601
# server.host: "0.0.0.0"
# elasticsearch.hosts: ["http://localhost:9200"]
# ---

# Запускаем kibana:
systemctl enable --now kibana && clear && systemctl status kibana && sleep 5 && \

