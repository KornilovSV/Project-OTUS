#!/bin/bash
# Crontab

if [[ -d ~/Git ]];
 then
  echo "Directory present" && sleep 5
 else
  mkdir ~/Git
fi

mkdir /home/BackUp/ && \
cp mysql-backup.sh /home/BackUp/ && \
cp git-pull.sh ~/Git/git-pull.sh && \
cp cron /var/spool/cron/root && \
crontab -e

systemctl status crond.service -l | grep -A2 "e - Command"
echo " "
crontab -l
#
