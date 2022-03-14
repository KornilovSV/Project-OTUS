#!/bin/bash

# "Find out the external IP address in Linux" script from KSV

MYIP1=$(wget -qO- eth0.me);
MYIP2=$(wget -qO- icanhazip.com);
echo $MYIP1;
echo $MYIP2;

echo "---------------"
echo "Geo location"
curl https://ipinfo.io/$MYIP1

echo $MYIP1 >> My_ext_IP.txt

# END
