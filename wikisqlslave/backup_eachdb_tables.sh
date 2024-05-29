#!/bin/bash

PATH=$PATH:/usr/local/bin

DIR=`date +"%Y-%m-%d"`
DATE=`date +"%Y%m%d-%H%M"`
MYSQL='mysql --skip-column-names'

`mysql -e "STOP REPLICA"`;
for d in `$MYSQL -e "SHOW DATABASES"`;
do
    mkdir /home/anton/sql_backup/"${d}_${DATE}";
    for t in `$MYSQL -e "SHOW TABLES from $d"`;
    do
    /usr/bin/mysqldump --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers $d --tables $t| gzip -1 > /home/anton/sql_backup/"${d}_${DATE}"/$t.gz;
    done
done
`mysql -e "START REPLICA"`;