#!/bin/bash
# Installing MySQL on Linux Using the MySQL Yum Repository

cp .my.cnf ~/.my.cnf && chmod 0600 ~/.my.cnf && \
mkdir ~/MysQL && cd ~/MysQL && \

# Adding the MySQL Yum Repository For an EL7-based system:
curl -LO https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm && \
yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm && \
yum -y update && clear && \
yum repolist enabled | grep mysql && \
sleep 7

# Installing MySQL
yum -y install mysql-community-server && \
clear && echo "Get Start MySQL, wait a few minutes " && \
systemctl start mysqld && systemctl status mysqld && \
sleep 7

# A superuser account 'root'@'localhost is created.
# A password for the superuser is set and stored in the error log file.
# To reveal it, use the following command:
echo "Default password: "
# supwd=$(grep 'temporary password' /var/log/mysqld.log)
grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}'
# grep 'temporary password' /var/log/mysqld.log > MySQL_temp.pwd
# defpwd=$(cat MySQL_temp.pwd | awk '{print $NF}')
# echo $defpwd

# echo Change the root password by logging in with the generated,
# echo temporary password and set a custom password for the superuser account:
# echo mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY '<MyNewPwd';
sleep 10

#
mysql_secure_installation && \
echo "Enter password to login MySQL: "
mysql -uroot -p
