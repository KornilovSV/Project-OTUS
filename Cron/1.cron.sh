#!/bin/bash
# Crontab

if [[ -d ~/Git ]];
 then
  clear && echo "Directory ~/Git present" && sleep 5
 else
  mkdir ~/Git
fi

if [[ -d /home/BackUp ]];
 then
  clear && echo "Directory "/home/BackUP" present" && sleep 5
 else
  mkdir /home/BackUp
fi

cp -iv mysql-backup.sh /home/BackUp/ && \
cp -iv git-pull.sh ~/Git/git-pull.sh && \
cp -iv cron /var/spool/cron/root && \
crontab -e

clear
systemctl status crond.service -l | grep -A2 "e - Command"
echo " "
crontab -l
sleep 5
#
