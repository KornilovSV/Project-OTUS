#!/bin/bash
# Install apache:

yum install -y epel-release httpd && \
systemctl start httpd && \
clear && \
ss -tlnp | grep "80"
sleep 7
clear && \
curl localhost | head
sleep 7
clear && \
systemctl enable httpd && \
clear && \

echo "2-nd Autostart Apache:"
systemctl is-enabled httpd

# END
