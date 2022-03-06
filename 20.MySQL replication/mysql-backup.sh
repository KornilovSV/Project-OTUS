#!/bin/bash

# MySQL 8.0 Backup script

echo "Enter password for mysql(root): "
read -s PWD1

# Dump database:
MYSQL='mysql --skip-column-names'

for d in mysql `$MYSQL -e "SHOW DATABASES LIKE '%\_db'"`;
do
   mkdir $d
   /usr/bin/mysqldump -uroot -p$PWD1 --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers $d | gzip -1 > ./$d/$d.gz;

   for t in $(mysql -uroot -p$PWD1 $d -e "show tables;"|grep -v Tables_in_);
     do
     /usr/bin/mysqldump -uroot -p$PWD1 --add-locks --quick --create-options --extended-insert --single-transaction --set-charset --master-data=2 $d $t 2> /dev/null | gzip > ./$d/$t".gz";
     done
done

# Clear password
PWD1=":)"

echo $PWD1

# Clear password
PWD1=":)"

echo $PWD1

