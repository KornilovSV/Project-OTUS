Установка Nginx - Apache

1. Вначале запускаем скрипты установки пакетов:
    srv1_1.1.niginx_apache_inst.sh на srv1
    srv2_1.1.apache_inst.sh на srv2

2. Запускаем скрипты настройки nginx - apache:
    srv1_1.2.niginx_apache_conf.sh на srv1
    srv2_1.2.apache_conf.sh на srv2
    
Копируются файлы настройки, конфиги тестируются на правильность нанстройки.

3. На srv2 скрипт выдаёт IP-адрес хоста, необходимо в файле
    /etc/nginx/conf.d/backend.conf прописать IP-адрес srv2 

    upstream backend {
	server 127.0.0.1:8081;
	server 127.0.0.1:8082;
    server ip-address srv2:8083 weight=2;
}

4. Выполням:
    systemctl reload nginx

Настройка закончена.

