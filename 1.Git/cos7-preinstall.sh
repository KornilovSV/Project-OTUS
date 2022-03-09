#!/bin/bash
# Preinstall CentOS 7

yum check-update && yum update && \
yum -y install nano wget tmux lynx mc && \
cp -iv tmux.conf /etc/tmux.conf && clear && \
tmux -V && sleep 5 && vi /etc/tmux.conf

setenforce 0 && clear && getenforce && \
systemctl disable --now firewalld && cleep 5 && \
iptables -L && sleep 5 && mc

