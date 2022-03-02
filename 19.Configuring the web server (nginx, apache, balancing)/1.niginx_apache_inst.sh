#!/bin/bash
# Install niginx_apache:

yum install -y epel-release nginx httpd && \

systemctl start nginx && \ 
ss -tlnp | grep "*:80"
sleep 5
clear
curl localhost | head
sleep 5
clear
systemctl enable nginx && systemctl is-enabled nginx && \
sleep 3
clear
systemctl stop nginx && \

systemctl start httpd && \
ss -tlnp | grep "*80"
sleep 5
clear
curl localhost | head
sleep 5
clear
systemctl enable httpd && systemctl is-enabled httpd && \
sleep 5
systemctl stop httpd && \

systemctl is-enabled nginx
# END
