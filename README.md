# Project-OTUS
# 10.03.2022 v.6

Protection of project work

Infrastructure:

 1. cos-7-srv1 -- 192.168.88.101
        nginx :80	-- балансировщик нагрузки
        httpd :8081
        httpd :8082
        mysql source

 2. pve-cos-7-srv2 -- 10.10.10.nn
        httpd :8083
        mysql replica

 3. pve-cos-7-srv3 -- 10.10.10.100 ; On Proxmox 7.x host
        monitoring -- prometheus + grafana
        logging	   -- ELK stack

--------------------------------------------
Network schem
                     192.168.88.0/24                   10.10.10.0/24
Inet -- [Mikrotik] ------------------- [Cisco 861-K9] ---------------
                          |                                  |
                          |                                  |          
                   vbox: cos7-srv1                         PVE 7.x
                                                       --------------
                                                       vms: cos7-srv2
                                                            cos7-srv3

