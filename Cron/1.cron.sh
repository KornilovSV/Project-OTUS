#!/bin/bash
# Crontab

mkdir /home/BackUp/ && \
cp mysql-backup.sh /home/BackUp/ && \
cp git-pull.sh ~/Git/git-pull.sh && \
cp cron /var/spool/cron/root && \

systemctl status crond.service -l | grep -A2 "e - Command"
echo " "
crontab -l
#
