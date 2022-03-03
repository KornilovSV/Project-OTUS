#!/bin/bash
# Install niginx_apache:

yum install -y epel-release nginx && \
systemctl stop nginx && \
yum install -y httpd && systemctl stop httpd && \

systemctl start nginx && \
clear && \
ss -tlnp | grep "*:80"
sleep 7
clear && \
curl localhost | head
sleep 7
systemctl enable nginx && \
systemctl stop nginx && \

systemctl start httpd && \
clear && \
ss -tlnp | grep "*80"
sleep 7
clear && \
curl localhost | head
sleep 7
systemctl disable --now httpd && \
clear && \

echo "Autostart Nginx, Apache:"
systemctl is-enabled nginx && \
systemctl is-enabled httpd

# END