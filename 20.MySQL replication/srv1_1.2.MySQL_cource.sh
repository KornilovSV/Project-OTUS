#####################################################
# На Мастере
#####################################################

# Создаём пользователя для реплики в MySQL
mysql -e "CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';"

# Даём ему права на репликацию
GRANT REPLICATION SLAVE ON *.* TO repl@'%';

# Сбрасываем кэш привилегий (не обязательно)
# FLUSH PRIVILEGES;

# Смотрим пользователей
SELECT User, Host FROM mysql.user;

# Смотрим статус Мастера
SHOW MASTER STATUS;

