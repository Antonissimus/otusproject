#!/bin/bash

PATH=$PATH:/usr/local/bin

DIR=`date +"%Y-%m-%d"`
DATE=`date +"%Y%m%d-%H%M"`
MYSQL='mysql --skip-column-names'

`mysql -e "STOP REPLICA"`;

mkdir /home/anton/sql_backup/"bookstack_full_${DATE}";

/usr/bin/mysqldump --set-gtid-purged=OFF -u root bookstack > /home/anton/sql_backup/"bookstack_full_${DATE}"/bookstack.backup.sql;

`mysql -e "START REPLICA"`;