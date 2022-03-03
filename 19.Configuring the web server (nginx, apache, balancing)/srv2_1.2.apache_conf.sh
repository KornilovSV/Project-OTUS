#!/bin/bash

# Copy httpd conf files:
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_orig && \
cp srv2_1.4.0_httpd.conf /etc/httpd/conf/httpd.conf && \

cp srv2_1.4.1_vh3.conf /etc/httpd/conf.d/vh3.conf && \
cp index-vh3.html /var/www/html/index.html && \

echo "Config files check:"
clear && apachectl -t && sleep 10 && \

systemctl reload httpd && \
clear  && \
ss -tln
sleep 10

