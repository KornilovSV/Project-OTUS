#!/bin/bash

# Copy niginx conf files:
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_orig && \
cp srv1_1.2_nginx.conf /etc/nginx/nginx.conf && \
cp srv1_1.3_nginx_backend.conf /etc/nginx/conf.d/backend.conf && \

# Copy httpd conf files:
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig && \
cp srv1_1.4.0_httpd.conf /etc/httpd/conf/httpd.conf && \
cp srv1_1.4.1_vh1.conf /etc/httpd/conf.d/vh1.conf && \
cp srv1_1.4.1_vh2.conf /etc/httpd/conf.d/vh2.conf && \
mkdir /var/www/html1 /var/www/html2 && \
cp index-vh1.html /var/www/html1/index.html && \
cp index-vh2.html /var/www/html2/index.html && \

echo "Config files check:"
clear && apachectl -t && \
nginx -t && sleep 10 && \

systemctl enable --now httpd && \
systemctl start nginx && \

clear  && \
ss -tln
sleep 10

