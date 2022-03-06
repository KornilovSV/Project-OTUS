#!/bin/bash
# Crontab

mkdir /home/BackUp/ && \
cp mysql-backup.sh /home/BackUp/ && \
cp git-pull.sh ~/Git/git-pull.sh && \
cp cron /var/spool/cron/root && \

systemctl status crond.service -l
echo " "
crontab -l
#
