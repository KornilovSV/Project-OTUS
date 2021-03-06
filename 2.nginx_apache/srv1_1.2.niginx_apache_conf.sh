#!/bin/bash
# Developed by KornilovSV

# Copy niginx conf files:
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_orig && \
cp -iv srv1_1.2_nginx.conf /etc/nginx/nginx.conf && \
cp -v srv1_1.3_nginx_backend.conf /etc/nginx/conf.d/backend.conf && \

# Copy httpd conf files:
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig && \
cp srv1_1.4.0_httpd.conf /etc/httpd/conf/httpd.conf && \
# cp srv1_1.4.1_vh1.conf /etc/httpd/conf.d/vh1.conf && \
cp srv1_1.4.1_vh2.conf /etc/httpd/conf.d/vh2.conf && \
mkdir /var/www/html1 /var/www/html2 && \
cp index-vh1.html /var/www/html1/index.html && \
cp index-vh2.html /var/www/html2/index.html && \

clear && echo "Config files check:" && \
apachectl -t && \
nginx -t && sleep 5 && \

systemctl enable --now httpd && \
systemctl start nginx && \
sleep 10 && clear && ss -tln && \
echo " "
cat /etc/nginx/conf.d/backend.conf | head && \
sleep 5

#END
