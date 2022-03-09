#!/bin/bash
#
# !!! IN PROGRESS !!!

#############################################################
ELK setup
#############################################################

yum -y install java-openjdk-devel java-openjdk && \
cat <<EOF | sudo tee /etc/yum.repos.d/elasticsearch.repo
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo yum clean all && sudo yum makecache && sudo yum -y install elasticsearch && \
rpm -qi elasticsearch

#; URL         : https://www.elastic.co/
#; Reference documentation can be found at
#;  https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
#;  and the 'Elasticsearch: The Definitive Guide' book can be found at
#;  https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html

# Устанавливаем лимиты памяти для виртуальной машины Java
cat jvm.options /etc/elasticsearch/jvm.options.d/jvm.options

####

# Запускаем сервис elasticsearch
sudo systemctl enable --now elasticsearch.service && sleep 10 &&\

# Проверяем
clear && curl http://127.0.0.1:9200

# Создаём тестовый индекс
curl -X PUT "http://127.0.0.1:9200/mytest_index"


#### Установка KIBANA ####
sudo yum -y install kibana

sudo nano /etc/kibana/kibana.yml
# server.port: 5601
# server.host: "0.0.0.0"
# elasticsearch.hosts: ["http://localhost:9200"]

sudo systemctl enable --now kibana && sleep 10 && \

#; sudo firewall-cmd --add-port=5601/tcp --permanent
#; sudo firewall-cmd --reload
#; systemctl stop firewalld

#### Установка Logstash ####
sudo yum -y install logstash filebeat auditbeat metricbeat packetbeat heartbeat-elastic

#; BEATS это ставим на другом хосте, если нужно
#; sudo yum -y install filebeat auditbeat metricbeat packetbeat heartbeat-elastic

# logstash config
sudo nano /etc/logstash/logstash.yml

#path.data: /var/lib/logstash
#path.config: /etc/logstash/conf.d
#path.logs: /var/log/logstash

grep ^path. /etc/logstash/logstash.yml

# ---------------------------------
cp -iv logstash-nginx-es.conf /etc/logstash/conf.d/logstash-nginx-es.conf

##############################

sudo systemctl restart logstash.service && \

# ---------------------------------
# Filebeat config

sudo nano /etc/filebeat/filebeat.yml

---------------------------------
# systemctl start nginx

# Ходим по 80 порту, собираем логи nginx
http://192.168.88.101/

# Заходим на панель Kibana
http://192.168.88.101:5601/app/home#/

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

#END
