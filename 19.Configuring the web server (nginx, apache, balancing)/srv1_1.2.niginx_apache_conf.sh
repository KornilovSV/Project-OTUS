#!/bin/bash
# Copy conf files niginx_apache:

# Backup orig conf file:
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_orig && \
cp srv1_1.2_nginx_main.conf /etc/nginx/nginx.conf && \
cp srv1_1.3_nginx_backend.conf /etc/nginx/conf.d/backend.conf

systemctl start nginx && \
clear  && \
nginx -t && \
sleep 7
# systemctl reload nginx && \

# Copy httpd
# /etc/httpd/conf/httpd.conf
# clear  && \
# apachectl -t && \
# sleep 7
# systemctl reload nginx && \
# /var/www/html
