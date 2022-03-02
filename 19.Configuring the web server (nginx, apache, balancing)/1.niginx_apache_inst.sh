#!/bin/bash
# Install niginx_apache:

yum install epel-release && \
yum install -y nginx httpd && \

systemctl start nginx && systemctl status nginx
ps -fax | grep -A 3 nginx
ss -tlnp | grep -A 2 "*:80"
# curl localhost 80
sleep 5
# systemctl enable nginx && systemctl is-enabled nginx
sleep 3
systemctl stop nginx

systemctl start httpd && systemctl status httpd
ps -fax | grep -A 3 httpd
# curl localhost 80
systemctl enable httpd && systemctl is-enabled httpd
sleep 5
ps fax | grep httpd

# END
