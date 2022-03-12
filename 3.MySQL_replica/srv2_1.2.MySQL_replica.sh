#!/bin/bash

######################################################
# On Replica
######################################################

# Copy Backup-scripts
cp -iv mysql-backup.sh ~/MySQL && \
cp -iv mysql-backup-tbl.sh ~/MySQL && \

# Change server_id on Slave:
echo "server_id = 2" >> /etc/my.cnf && systemctl restart mysqld && \
echo "Current server_id on Slave: " && \
mysql -e "select @@server_id;" && sleep 3 && \

mysql -e "STOP SLAVE;" && \
echo "Change: Master_IP, Binlog_number, POS_number: "
echo "In the following command: "
echo "CHANGE MASTER TO MASTER_HOST='192.168.4.50', MASTER_USER='repl', MASTER_PASSWORD='oTUSlave#2020', MASTER_LOG_FILE='binlog.000XXX', MASTER_LOG_POS=XXX, GET_MASTER_PUBLIC_KEY = 1;"
echo " "
echo "And paste this line into: mysql > " && sleep 5 && \
echo " "
mysql -uroot && \
mysql -e "START SLAVE;" && \
sleep 10 && \

cd ~/MySQL && \
echo "Show slave status:" && mysql -e "show slave status\G"

# mysql -e "show variables like '%binlog%';"

# For slave_read_only mode:
# /etc/my.cnf
# innodb_read_only = 1

# State Management Commands
# STOP SLAVE;
# START SLAVE;

