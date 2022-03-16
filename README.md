# Project-OTUS
# 12.03.2022 v.7

Protection of project work

Infrastructure:

 1. pve-cos-7-srv1 -- 10.10.10.100
        nginx :80
        httpd :8081
        httpd :8082
        ELK steck

 2. pve-cos-7-srv2 -- 10.10.10.104
        httpd :8083
        mysql source
        monitoring -- prometheus + grafana

 3. cos-7-srv3 -- 192.168.88.103
        mysql replica

--------------------------------------------
Diagram of my home network: 

                     192.168.88.0/24                   10.10.10.0/24
Inet -- [Mikrotik] ------------------- [Cisco 861-K9] ---------------
                          |                                  |
                          |                                  |          
                   vbox: cos7-srv3                         PVE 7.x
                                                       --------------
                                                       vms: cos7-srv1
                                                            cos7-srv2

