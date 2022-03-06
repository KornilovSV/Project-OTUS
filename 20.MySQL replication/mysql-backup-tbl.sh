#!/bin/bash
# MySQL 8.0 Backup script
# With a choice of databases

mysqlshow

echo -n "Enter name of database: "
read DB

if [ -d ~/MySQL/$DB ]
  then
    echo "OK" > /dev/null
  else
    cd ~/MySQL/
    mkdir $DB
fi

# Stop Slave:
mysql -e "stop slave;" && \
echo "Slave status: "
mysql -e "show slave status\G" | grep Running

# BackUp bases:
for i in $(mysql -uroot $DB -e "show tables;"|grep -v Tables_in_);
    do
    /usr/bin/mysqldump -uroot --add-locks --quick --create-options --extended-insert --single-transaction --set-charset --master-data=2 $DB $i 2> /dev/null | gzip > ./$DB/$i".gz";
    done

# Start Slave:
mysql -e "start slave;" && \
echo "Slave status: "
mysql -e "show slave status\G" | grep Running
