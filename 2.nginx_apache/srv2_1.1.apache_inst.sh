#!/bin/bash
### Install apache ###
# Developed by KornilovSV

yum install -y epel-release httpd && \
systemctl start httpd && \
clear && ss -tlnp | grep "httpd" && sleep 7 && \
clear && curl localhost | head && sleep 7 && \
clear && systemctl enable httpd && clear && \

echo "Autostart Apache:"
systemctl is-enabled httpd

# END
