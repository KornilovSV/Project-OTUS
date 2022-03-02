#!/bin/bash
# Install niginx_apache:

yum install -y epel-release nginx && \
systemctl stop nginx && \
yum install -y httpd && systemctl stop  httpd && \

systemctl start nginx && \
clear && \
ss -tlnp | grep "*:80"
sleep 5
clear && \
curl localhost | head
sleep 5
systemctl enable nginx && \
systemctl stop nginx && \

systemctl start httpd && \
clear && \
ss -tlnp | grep "*80"
sleep 5
clear && \
curl localhost | head
sleep 5
systemctl disable --now httpd && \

echo "Autostart Nginx, Apache:"
systemctl is-enabled nginx && \
systemctl is-enabled httpd

# END
