#!/bin/bash

# Restore wikiweb
echo устанавливаем nginx
ssh -i ~/.ssh/id_rsa_root root@wikiweb "apt install nginx"

echo переносим конфигурацию nginx
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikiweb/nginx/default root@wikiweb:/etc/nginx/sites-available/default
ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl restart nginx"

echo устанавливаем node-exporter
ssh -i ~/.ssh/id_rsa_root root@wikiweb "curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "tar xzvf node_exporter-*.t*gz"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "useradd --no-create-home --shell /bin/false node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "cp -r node_exporter-*.linux-amd64/node_exporter /usr/local/bin"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "chown node_exporter: /usr/local/bin/node_exporter"

echo переносим конфигурацию node-exporter
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikiweb/node-exporter/node_exporter.service root@wikiweb:/etc/systemd/system/node_exporter.service
ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl start node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl enable node_exporter"

echo устанавливаем filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/Загрузки/filebeat_8.9.1_amd64-224190-507082.deb root@wikiweb:/home/anton/filebeat_8.9.1_amd64.deb
ssh -i ~/.ssh/id_rsa_root root@wikiweb "dpkg -i /home/anton/filebeat_8.9.1_amd64.deb"

echo переносим конфигурацию filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikiweb/filebeat/filebeat.yml root@wikiweb:/etc/filebeat/filebeat.yml
ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl restart filebeat"
ssh -i ~/.ssh/id_rsa_root root@wikiweb "systemctl enable filebeat"

# Restore wikibackprimary
echo устанавливаем bookstack
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/scripts/installation-ubuntu-24.04.sh root@wikibackprimary:/home/anton/installation-ubuntu-24.04.sh
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "/home/anton/installation-ubuntu-24.04.sh"

echo переносим конфигурацию apache
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/apache/bookstack.conf root@wikibackprimary:/etc/apache2/sites-available/bookstack.conf
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl restart apache2"

echo переносим конфигурацию bookstack
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/bookstack/.env root@wikibackprimary:/var/www/bookstack/.env

echo устанавливаем node-exporter
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "tar xzvf node_exporter-*.t*gz"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "useradd --no-create-home --shell /bin/false node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "cp -r node_exporter-*.linux-amd64/node_exporter /usr/local/bin"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "chown node_exporter: /usr/local/bin/node_exporter"

echo переносим конфигурацию node-exporter
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/node-exporter/node_exporter.service root@wikibackprimary:/etc/systemd/system/node_exporter.service
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl start node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl enable node_exporter"

echo устанавливаем filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/Загрузки/filebeat_8.9.1_amd64-224190-507082.deb root@wikibackprimary:/home/anton/filebeat_8.9.1_amd64.deb
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "dpkg -i /home/anton/filebeat_8.9.1_amd64.deb"

echo переносим конфигурацию filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibackprimary/filebeat/filebeat.yml root@wikibackprimary:/etc/filebeat/filebeat.yml
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl restart filebeat"
ssh -i ~/.ssh/id_rsa_root root@wikibackprimary "systemctl enable filebeat"

# Restore wikibacksecondary
echo устанавливаем bookstack
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/scripts/installation-ubuntu-24.04.sh root@wikibacksecondary:/home/anton/installation-ubuntu-24.04.sh
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "/home/anton/installation-ubuntu-24.04.sh"

echo переносим конфигурацию apache
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibacksecondary/apache/bookstack.conf root@wikibacksecondary:/etc/apache2/sites-available/bookstack.conf
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl restart apache2"

echo переносим конфигурацию bookstack
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibacksecondary/bookstack/.env root@wikibacksecondary:/var/www/bookstack/.env

echo устанавливаем node-exporter
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz"
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "tar xzvf node_exporter-*.t*gz"
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "useradd --no-create-home --shell /bin/false node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "cp -r node_exporter-*.linux-amd64/node_exporter /usr/local/bin"
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "chown node_exporter: /usr/local/bin/node_exporter"

echo переносим конфигурацию node-exporter
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikibacksecondary/node-exporter/node_exporter.service root@wikibacksecondary:/etc/systemd/system/node_exporter.service
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl start node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikibacksecondary "systemctl enable node_exporter"

Restore wikisqlmaster, wikisqlslave
echo устанавливаем mysql на wikisqlmaster
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "apt install -y mysql-server-8.0"

echo устанавливаем mysql на wikisqlslave
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "apt install -y mysql-server-8.0"

echo восстанавливаем конфигурацию wikisqlmaster
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/mysql/mysqld.cnf root@wikisqlmaster:/etc/mysql/mysql.conf.d/mysqld.cnf
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl restart mysql"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster <<'ENDSSH'

mysql -u root --execute="CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2024';"
mysql -u root --execute="GRANT REPLICATION SLAVE ON *.* TO repl@'%';"
mysql -u root --execute="FLUSH TABLES WITH READ LOCK;"

ENDSSH

echo восстанавливаем конфигурацию wikisqlslave
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/mysql/mysqld.cnf root@wikisqlslave:/etc/mysql/mysql.conf.d/mysqld.cnf
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl restart mysql"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave <<'ENDSSH'

mysql -u root --execute="STOP REPLICA;"
mysql -u root --execute="CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.1.203', SOURCE_USER='repl', SOURCE_PASSWORD='oTUSlave#2024', SOURCE_AUTO_POSITION = 1, GET_SOURCE_PUBLIC_KEY = 1;"
mysql -u root --execute="START REPLICA;"

ENDSSH

ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl restart mysql"

echo устанавливаем node-exporter
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "tar xzvf node_exporter-*.t*gz"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "useradd --no-create-home --shell /bin/false node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin/node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "chown node_exporter: /usr/local/bin/node_exporter"

echo переносим конфигурацию node-exporter
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/node-exporter/node_exporter.service root@wikisqlmaster:/etc/systemd/system/node_exporter.service
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl start node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl enable node_exporter"

echo устанавливаем node-exporter
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "tar xzvf node_exporter-*.t*gz"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "useradd --no-create-home --shell /bin/false node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin/node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "chown node_exporter: /usr/local/bin/node_exporter"

echo переносим конфигурацию node-exporter
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/node-exporter/node_exporter.service root@wikisqlslave:/etc/systemd/system/node_exporter.service
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl start node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "systemctl enable node_exporter"

echo устанавливаем filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/Загрузки/filebeat_8.9.1_amd64-224190-507082.deb root@wikisqlmaster:/home/anton/filebeat_8.9.1_amd64.deb
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "dpkg -i /home/anton/filebeat_8.9.1_amd64.deb"

echo переносим конфигурацию filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/filebeat/filebeat.yml root@wikisqlmaster:/etc/filebeat/filebeat.yml
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl restart filebeat"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl enable filebeat"

echo переносим скрипты потабличного бэкапа
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/backup_eachdb_tables.sh root@wikisqlslave:/home/anton/backup_eachdb_tables.sh
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "chmod +x /home/anton/backup_eachdb_tables.sh"
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlslave/backup_bookstack.sh root@wikisqlslave:/home/anton/backup_bookstack.sh
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "chmod +x /home/anton/backup_bookstack.sh"
ssh -i ~/.ssh/id_rsa_root root@wikisqlslave "mkdir -p /home/anton/sql_backup/"
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/restore_bookstack_fromtables.sh root@wikisqlmaster:/home/anton/restore_bookstack_fromtables.sh
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "chmod +x /home/anton/restore_bookstack_fromtables.sh"


echo переносим бэкап на мастер
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "mkdir -p /home/anton/sql_backup/"
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/bookstack.backup.sql root@wikisqlmaster:/home/anton/sql_backup/bookstack.backup.sql

echo восстанавливаем базу bookstack
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster <<'ENDSSH'

mysql -u root --execute="CREATE DATABASE bookstack;"
mysql -u root --execute="CREATE USER 'bookstack'@'localhost' IDENTIFIED WITH mysql_native_password BY 'p4ssword';"
mysql -u root --execute="CREATE USER 'bookstack'@'%' IDENTIFIED WITH mysql_native_password BY 'p4ssword';"
mysql -u root --execute="GRANT ALL ON bookstack.* TO 'bookstack'@'localhost';FLUSH PRIVILEGES;"
mysql -u root --execute="GRANT ALL ON bookstack.* TO 'bookstack'@'%';FLUSH PRIVILEGES;"
mysql -u root bookstack < /home/anton/sql_backup/bookstack.backup.sql

ENDSSH

# Restore wikimonitor
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "apt update"

echo устанавливаем prometheus
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "apt install -y prometheus"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "curl -LO https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "tar xzvf prometheus-*.t*gz"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/"

echo переносим конфигурацию prometheus
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikimonitor/prometheus/prometheus.yml root@wikimonitor:/etc/prometheus/prometheus.yml
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikimonitor/prometheus/prometheus.service root@wikimonitor:/etc/systemd/system/prometheus.service
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "systemctl restart prometheus"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "systemctl enable prometheus"

echo устанавливаем grafana
scp -i ~/.ssh/id_rsa_root /home/anton/Загрузки/grafana-enterprise_11.0.0_amd64.deb root@wikimonitor:/home/anton/grafana-enterprise_11.0.0_amd64.deb
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "apt install -y musl"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "dpkg -i /home/anton/grafana-enterprise_11.0.0_amd64.deb"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikimonitor "systemctl start grafana-server"

# # Restore wikilogs
# echo переносим конфигурацию java
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikilogs/java/jvm.options root@wikilogs:/etc/elasticsearch/jvm.options.d/jvm.options

# echo переносим конфигурацию logstash
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikilogs/logstash/logstash.yml root@wikilogs:/etc/logstash/logstash.yml
# scp -i ~/.ssh/id_rsa_root -r /home/anton/otusproject/wikilogs/logstash/conf.d root@wikilogs:/etc/logstash/conf.d
# ssh -i ~/.ssh/id_rsa_root root@wikilogs "systemctl restart logstash"

# echo переносим конфигурацию elasticsearch
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikilogs/elasticsearch/elasticsearch.yml root@wikilogs:/etc/elasticsearch/elasticsearch.yml
# ssh -i ~/.ssh/id_rsa_root root@wikilogs "systemctl restart elasticsearch"

# echo переносим конфигурацию kibana
# scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikilogs/kibana/kibana.yml root@wikilogs:/etc/kibana/kibana.yml
# ssh -i ~/.ssh/id_rsa_root root@wikilogs "systemctl restart kibana"


echo DR завершен