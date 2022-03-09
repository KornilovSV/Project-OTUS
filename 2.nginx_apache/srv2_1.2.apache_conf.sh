#!/bin/bash
# Developed by KornilovSV

# Copy httpd conf files:
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig && \
cp srv2_1.4.0_httpd.conf /etc/httpd/conf/httpd.conf && \

cp srv2_1.4.1_vh3.conf /etc/httpd/conf.d/vh3.conf && \
cp index-vh3.html /var/www/html/index.html && \

clear && echo "Config files check:" && \
apachectl -t && sleep 5 && echo "Reload httpd" && \
systemctl reload httpd && \
clear  && sleep 10 && ss -tln && \
echo ""
echo -n "Inet ExtIP: " && wget -qO- eth0.me && \
echo ""
echo -n "Host IP: "
ip -c a | grep enp
sleep 5

