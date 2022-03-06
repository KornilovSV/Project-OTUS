#!/bin/bash
# MySQL 8.0 Backup script

dtime=$(date "+%F_%R")
mkdir $dtime && cd $dtime

# Stop Slave:
mysql -e "stop slave;" && \
echo "Slave status: "
mysql -e "show slave status\G" | grep Running

MySQL='mysql --skip-column-names'

for db in mysql `$MySQL -e "SHOW DATABASES"`;
do
   mkdir $db;
   mkdir full_$db;
   /usr/bin/mysqldump -uroot --opt --single-transaction --events --routines --triggers --master-data=2 $db | gzip -1 > ./full_$db/$db.gz;

   for tbl in $(mysql -uroot $db -e "show tables;"|grep -v Tables_in_);
     do
     /usr/bin/mysqldump -uroot --opt --single-transaction --master-data=2 $db $tbl 2> /dev/null | gzip -1 > ./$db/$tbl".gz";
     done
done

# Start Slave:
mysql -e "start slave;" && \
echo "Slave status: "
mysql -e "show slave status\G" | grep Running
sleep 5 && cd ..

# END
