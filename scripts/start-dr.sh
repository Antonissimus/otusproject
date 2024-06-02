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

# Restore wikisqlmaster
echo восстанавливаем конфигурацию mysql
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/mysql/mysqld.cnf root@wikisqlmaster:/etc/mysql/mysql.conf.d/mysqld.cnf
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl restart mysql"



echo переносим конфигурацию node-exporter
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/node-exporter/node_exporter.service root@wikisqlmaster:/etc/systemd/system/node_exporter.service
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl daemon-reload"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl start node_exporter"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl enable node_exporter"

echo переносим конфигурацию filebeat
scp -i ~/.ssh/id_rsa_root /home/anton/otusproject/wikisqlmaster/filebeat/filebeat.yml root@wikisqlmaster:/etc/filebeat/filebeat.yml
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl restart filebeat"
ssh -i ~/.ssh/id_rsa_root root@wikisqlmaster "systemctl enable filebeat"

# Restore wikisqlslave
# Restore wikimonitor
# Restore wikilogs