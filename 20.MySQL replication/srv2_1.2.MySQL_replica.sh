######################################################
# On Replica
######################################################

mysql -e "select @@server_id;"

# Смотрим статус Слейва
# mysql -e "SHOW MASTER STATUS;"
# sudo nano /etc/my.cnf

echo "server_id = 2" >> /etc/my.cnf && systemctl restart mysqld && \
mysql -e "select @@server_id;" && sleep 3 && \


SHOW GLOBAL VARIABLES LIKE 'caching_sha2_password_public_key_path';
SHOW STATUS LIKE 'Caching_sha2_password_rsa_public_key'\G

# необходимо получить публичный ключ
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='192.168.0.10', MASTER_USER='repl', MASTER_PASSWORD='oTUSlave#2020', MASTER_LOG_FILE='binlog.000005', MASTER_LOG_POS=688, GET_MASTER_PUBLIC_KEY = 1;
START SLAVE;
show slave status\G

# https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html
# можем настроить наш relay.log
show variables like '%relay%';

# посмотрим статусы репликации
use performance_schema;
show tables like '%replic%';
show variables like '%log_bin%';
show variables like '%binlog%';
show variables like '%read%';

# рекомендуется включать для слейва, иначе на слейве тоже можем вносить изменения
# /etc/my.cnf
innodb_read_only = 1


# КОМАНДЫ ДЛЯ УПРАВЛЕНИЯ СОСТОЯНИЕМ
STOP SLAVE;
START SLAVE;