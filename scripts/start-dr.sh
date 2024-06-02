#!/bin/bash

# Restore wikiweb

# echo переносим конфигурацию nginx
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikiweb/nginx/default root@wikiweb:/etc/nginx/sites-available/default
# ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl restart nginx"

# echo переносим конфигурацию node-exporter
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikiweb/node-exporter/node_exporter.service root@wikiweb:/etc/systemd/system/node_exporter.service
# ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl daemon-reload"
# ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl start node_exporter"
# ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl enable node_exporter"

# echo переносим конфигурацию filebeat
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikiweb/filebeat/filebeat.yml root@wikiweb:/etc/filebeat/filebeat.yml
# ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl restart filebeat"
# ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl enable filebeat"

# Restore wikibackprimary
# echo переносим конфигурацию apache
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/apache/bookstack.conf root@wikibackprimary:/etc/apache2/sites-available/bookstack.conf
# ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl restart apache2"

# echo переносим конфигурацию bookstack
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/bookstack/.env root@wikibackprimary:/var/www/bookstack/.env

# echo переносим конфигурацию node-exporter
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/node-exporter/node_exporter.service root@wikibackprimary:/etc/systemd/system/node_exporter.service
# ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl daemon-reload"
# ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl start node_exporter"
# ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl enable node_exporter"

# echo переносим конфигурацию filebeat
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/filebeat/filebeat.yml root@wikibackprimary:/etc/filebeat/filebeat.yml
# ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl restart filebeat"
# ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl enable filebeat"

# # Restore wikibacksecondary
# echo переносим конфигурацию apache
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibacksecondary/apache/bookstack.conf root@wikibacksecondary:/etc/apache2/sites-available/bookstack.conf
# ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl restart apache2"

# echo переносим конфигурацию bookstack
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibacksecondary/bookstack/.env root@wikibacksecondary:/var/www/bookstack/.env

# echo переносим конфигурацию node-exporter
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibacksecondary/node-exporter/node_exporter.service root@wikibacksecondary:/etc/systemd/system/node_exporter.service
# ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl daemon-reload"
# ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl start node_exporter"
# ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl enable node_exporter"

# Restore wikisqlmaster, wikisqlslave
# echo восстанавливаем конфигурацию sqlmaster
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/mysql/mysqld.cnf root@wikisqlmaster:/etc/mysql/mysql.conf.d/mysqld.cnf
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl restart mysql"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster <<'ENDSSH'

# mysql -u root --execute="CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2024';"
# mysql -u root --execute="GRANT REPLICATION SLAVE ON *.* TO repl@'%';"
# mysql -u root --execute="FLUSH TABLES WITH READ LOCK;"

# ENDSSH

# echo восстанавливаем конфигурацию sqlslaave
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/mysql/mysqld.cnf root@wikisqlslave:/etc/mysql/mysql.conf.d/mysqld.cnf
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl restart mysql"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave <<'ENDSSH'

# mysql -u root --execute="STOP REPLICA;"
# mysql -u root --execute="CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.1.203', SOURCE_USER='repl', SOURCE_PASSWORD='oTUSlave#2024', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;"
# mysql -u root --execute="START REPLICA;"

# ENDSSH

# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl restart mysql"



# echo переносим конфигурацию node-exporter
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/node-exporter/node_exporter.service root@wikisqlmaster:/etc/systemd/system/node_exporter.service
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl daemon-reload"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl start node_exporter"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl enable node_exporter"

# echo переносим конфигурацию node-exporter
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/node-exporter/node_exporter.service root@wikisqlslave:/etc/systemd/system/node_exporter.service
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl daemon-reload"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl start node_exporter"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl enable node_exporter"


# echo переносим конфигурацию filebeat
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/filebeat/filebeat.yml root@wikisqlmaster:/etc/filebeat/filebeat.yml
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl restart filebeat"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl enable filebeat"

# echo переносим скрипты потабличного бэкапа
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/backup_eachdb_tables.sh root@wikisqlslave:/home/anton/backup_eachdb_tables.sh
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "chmod +x /home/anton/backup_eachdb_tables.sh"
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/backup_bookstack.sh root@wikisqlslave:/home/anton/backup_bookstack.sh
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "chmod +x /home/anton/backup_bookstack.sh"
# ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "mkdir -p /home/anton/sql_backup/"
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/restore_bookstack_fromtables.sh root@wikisqlmaster:/home/anton/restore_bookstack_fromtables.sh
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "chmod +x /home/anton/restore_bookstack_fromtables.sh"


# echo переносим бэкап на мастер
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "mkdir -p /home/anton/sql_backup/"
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/bookstack.backup.sql root@wikisqlmaster:/home/anton/sql_backup/bookstack.backup.sql

# echo восстанавливаем базу bookstack
# ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster <<'ENDSSH'

# mysql -u root --execute="CREATE DATABASE bookstack;"
# mysql -u root --execute="CREATE USER 'bookstack'@'localhost' IDENTIFIED WITH mysql_native_password BY 'p4ssword';"
# mysql -u root --execute="CREATE USER 'bookstack'@'%' IDENTIFIED WITH mysql_native_password BY 'p4ssword';"
# mysql -u root --execute="GRANT ALL ON bookstack.* TO 'bookstack'@'localhost';FLUSH PRIVILEGES;"
# mysql -u root --execute="GRANT ALL ON bookstack.* TO 'bookstack'@'%';FLUSH PRIVILEGES;"
# mysql -u root bookstack < bookstack.backup.sql

# ENDSSH

# Restore wikimonitor

echo переносим конфигурацию prometheus
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikimonitor/prometheus/prometheus.yml root@wikimonitor:/etc/prometheus/prometheus.yml
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikimonitor/prometheus/prometheus.service root@wikimonitor:/etc/systemd/system/prometheus.service
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "systemctl restart prometheus"

# Restore wikilogs