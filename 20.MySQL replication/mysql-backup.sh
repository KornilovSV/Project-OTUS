#!/bin/bash
# MySQL 8.0 Backup script

dtime=$(date "+%F_%R")

# Dump database:
MySQL='mysql --user=root --skip-column-names'

# Stop Slave:
mysql -e "stop slave;" && \
echo "Slave status: "
mysql -e "show slave status\G" | grep Running

for d in mysql `$MySQL -e "SHOW DATABASES"`;
do
   mkdir '$d_$dtime'
   /usr/bin/mysqldump -uroot --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers $d | gzip -1 > ./$d/$d.gz;

#   for t in $(mysql -uroot $d -e "show tables;"|grep -v Tables_in_);
#     do
#     /usr/bin/mysqldump -uroot --add-locks --quick --create-options --extended-insert --single-transaction --set-charset --master-data=2 $d $t 2> /dev/null | gzip > ./$d/$t".gz";
#     done
done

# Start Slave:
mysql -e "start slave;" && \
echo "Slave status: "
mysql -e "show slave status\G" | grep Running