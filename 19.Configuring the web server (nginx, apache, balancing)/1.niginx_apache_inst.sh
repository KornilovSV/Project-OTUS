#!/bin/bash
# Install niginx_apache:

yum install -y epel-release nginx httpd && \

systemctl start nginx && systemctl status nginx
ss -tlnp | grep "*:80"
sleep 5
curl localhost | head
sleep 5
systemctl enable nginx && systemctl is-enabled nginx
sleep 3
systemctl stop nginx

systemctl start httpd && systemctl status httpd
ss -tlnp | grep "*80"
sleep 5
curl localhost | head
sleep 5
systemctl enable httpd && systemctl is-enabled httpd
sleep 5
systemctl stop httpd

# END
