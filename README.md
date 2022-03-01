# Project-OTUS
Protection of project work

Infrastructure:

 1. cos-7-srv1 -- 192.168.88.101
        nginx :80	-- балансировщик нагрузки
        httpd :8080
        httpd :8082
        mysql source

 2. cos-7-srv2 -- 192.168.88.102
        httpd :8081
        mysql replica

 3. pve-cos-7-srv3 -- 10.10.10.100
        monitoring -- prometheus + grafana
        logging	   -- ELK stack

--------------------------------------------
