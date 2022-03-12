# Project-OTUS
# 12.03.2022 v.7

Protection of project work

Infrastructure:

 1. cos-7-srv1 -- 10.10.10.100
        nginx :80	-- балансировщик нагрузки
        httpd :8081
        httpd :8082
        mysql source

 2. cos-7-srv2 -- 192.168.88.102
        httpd :8083
        mysql replica

 3. pve-cos-7-srv4 -- 10.10.10.104
        monitoring -- prometheus + grafana
        logging	   -- ELK stack

--------------------------------------------
Diagram of my home network: 

                     192.168.88.0/24                   10.10.10.0/24
Inet -- [Mikrotik] ------------------- [Cisco 861-K9] ---------------
                          |                                  |
                          |                                  |          
                   vbox: cos7-srv2                         PVE 7.x
                                                       --------------
                                                       vms: cos7-srv1
                                                            cos7-srv4

