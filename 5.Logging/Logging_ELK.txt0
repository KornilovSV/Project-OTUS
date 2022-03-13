# IN PROGRESS
#############################################################
# ELK setup
#############################################################

# Устанавливаем JRE
yum -y install java-openjdk-devel java-openjdk && \

# Создаем репозиторий elasticsearch:
cp -iv elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo

---
# cat <<EOF | sudo tee /etc/yum.repos.d/elasticsearch.repo
# [elasticsearch-7.x]
# name=Elasticsearch repository for 7.x packages
# baseurl=https://artifacts.elastic.co/packages/7.x/yum
# gpgcheck=1
# gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
# enabled=1
# autorefresh=1
# type=rpm-md
# EOF
# ---

# Импортируем ключ elasticsearch:
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \

# Устанавливаем elasticsearch:
yum clean all && sudo yum makecache && sudo yum -y install elasticsearch && \
clear && rpm -qi elasticsearch && sleep 5 && \ 

#; URL         : https://www.elastic.co/
#; Reference documentation can be found at
#;  https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
#;  and the 'Elasticsearch: The Definitive Guide' book can be found at
#;  https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html

# Устанавливаем лимиты памяти для виртуальной машины Java = 1GB
# !!! Проверить наличие --> cp -iv /etc/elasticsearch/jvm.options.d/jvm.options \
/etc/elasticsearch/jvm.options.d/jvm.options.back
cat jvm.options >> /etc/elasticsearch/jvm.options.d/jvm.options && \

# ------------------------------
# Запускаем сервис elasticsearch
systemctl enable --now elasticsearch.service && sleep 5 && \

# Проверяем
clear && ss -tln | grep 9300 && \
echo " " && curl http://127.0.0.1:9200 && sleep 5 && \

# !!! Создаём тестовый индекс
# curl -X PUT "http://127.0.0.1:9200/mytest_index"

# ------------------------------
#### Установка kibana ####
yum -y install kibana

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

# For firewalld chains
#; sudo firewall-cmd --add-port=5601/tcp --permanent
#; sudo firewall-cmd --reload
#; systemctl stop firewalld

# ------------------------------
#### Установка Logstash ####
yum -y install logstash && \
yum -y filebeat auditbeat metricbeat packetbeat heartbeat-elastic


#################################################
#; BEATS это ставим на других хостах, если нужно
#; sudo yum -y install filebeat auditbeat metricbeat packetbeat heartbeat-elastic
#################################################

# logstash config
mv /etc/logstash/logstash.yml /etc/logstash/logstash.yml.back && \
cp -iv logstash.yml /etc/logstash/logstash.yml

# sudo nano /etc/logstash/logstash.yml
# path.data: /var/lib/logstash
# path.config: /etc/logstash/conf.d
# path.logs: /var/log/logstash

# grep ^path. /etc/logstash/logstash.yml

#---------------------------------
cp -iv logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf && \
systemctl restart logstash.service

#---------------------------------
# Filebeat config

mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.yml.back && \
cp -iv filebeat.yml /etc/filebeat/filebeat.yml
chmod 600 /etc/filebeat/filebeat.yml

systemctl enable --now filebeat && systemctl restart filebeat && \
clear && systemctl status filebeat && sleep 5

====================================================

# systemctl start nginx

# Ходим по 80 порту, собираем логи nginx
http://10.10.10.100/

# Заходим на панель Kibana
http://10.10.10.100:5601/app/home#/

---------------------------------
Делаем настройку статистики
Analytics -- Discover -- Create Index pattern
Name: weblogs*, Timestamp field: @timestamp --> Create Index pattern


# Kibana - Index Patterns - Create Index pattern
# Name weblogs*, Timestamp field - @timestamp

Analytics - Discover - weblogs* (слева вверху)

(Дашбоард)
 Analytics - Dashboard - Create

# Bar horizontal - request.keyword host.ip.keyword
# Donut - slice by response, size by #records


