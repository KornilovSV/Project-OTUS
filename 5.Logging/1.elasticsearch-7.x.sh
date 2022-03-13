#############################################################
# ELK setup Elasticsearch
#############################################################

# Устанавливаем Java
yum -y install java-openjdk-devel java-openjdk && \

# Создаем репозиторий elasticsearch:
cp -iv elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo && \

# Импортируем ключ elasticsearch:
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch && \

# Устанавливаем elasticsearch:
yum clean all && yum makecache && \
yum -y install elasticsearch && \
systemctl daemon-reload && sleep 5 && \

#; URL         : https://www.elastic.co/
#; Reference documentation can be found at
#;  https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
#;  and the 'Elasticsearch: The Definitive Guide' book can be found at
#;  https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html

# Устанавливаем лимиты памяти для виртуальной машины Java = 1GB
cat jvm.options > /etc/elasticsearch/jvm.options.d/jvm.options && \

# ------------------------------
# Запускаем сервис elasticsearch
systemctl enable --now elasticsearch.service && sleep 5 && \

# systemctl start elasticsearch.service && \
clear && systemctl status elasticsearch.service && \
echo " " && ss -tlnp | grep java && sleep 5
rpm -qi elasticsearch && sleep 5 && \

# Проверяем
clear && echo " " && curl http://127.0.0.1:9200

# !!! Создаём тестовый индекс
# curl -X PUT "http://127.0.0.1:9200/mytest_index"

#END
