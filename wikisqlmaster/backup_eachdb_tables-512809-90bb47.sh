#!/bin/bash

PATH=$PATH:/usr/local/bin

DIR=`date +"%Y-%m-%d"`
DATE=`date +"%Y%m%d"`
MYSQL='mysql --skip-column-names'

for d in `$MYSQL -e "SHOW DATABASES"`;
do
    mkdir $d;
    for t in `$MYSQL -e "SHOW TABLES from $d"`;
    do
    /usr/bin/mysqldump --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers $d --tables $t| gzip -1 > $d/$t.gz;
    done
done
