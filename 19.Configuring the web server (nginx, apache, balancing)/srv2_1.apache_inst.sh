#!/bin/bash
# Install apache:

yum install -y epel-release httpd && \

systemctl start httpd && \
clear && \
ss -tlnp | grep "*80"
sleep 5
clear && \
curl localhost | head
systemctl enable httpd && \

echo "2-nd Autostart Apache:"
systemctl is-enabled httpd

# END
