#!/bin/bash
# MySQL 8.0 Backup script

echo "Enter password for mysql(root): "
read -s PWD1

mysql -uroot -p$PWD1 -e 'SHOW DATABASES';

echo -n "Enter name of database: "
read DB

if [ -d ~/MySQL/$DB ]
  then
    echo "OK" > /dev/null
  else
    cd ~/MySQL/
    mkdir $DB
fi

for i in $(mysql -uroot -p$PWD1 $DB -e "show tables;"|grep -v Tables_in_);
    do
    /usr/bin/mysqldump -uroot -p$PWD1 --add-locks --quick --create-options --extended-insert --single-transaction --set-charset --master-data=2 $DB $i 2> /dev/null | gzip > ./$DB/$i".gz";
    done

# Clear password
PWD1=":)"

echo $PWD1

