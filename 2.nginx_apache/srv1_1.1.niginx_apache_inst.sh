#!/bin/bash
# Install niginx_apache:
# Developed by KornilovSV

# Install packages:
yum install -y epel-release nginx && \
systemctl stop nginx && \
yum install -y httpd && systemctl stop httpd && \

# Status nginx:
systemctl start nginx && \
clear && ss -tlnp | grep "nginx" && sleep 7 &&\
clear && curl localhost | head && sleep 7 && \
systemctl enable nginx && \
systemctl stop nginx && \

# Status httpd:
systemctl start httpd && \
clear && ss -tlnp | grep "httpd" && sleep 7 && \
clear && curl localhost | head && sleep 5 && \
systemctl disable --now httpd && clear && \

echo "Autostart Nginx, Apache:"
systemctl is-enabled nginx && \
systemctl is-enabled httpd

# END
