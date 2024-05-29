#!/bin/bash

# Set MySQL connection details
MYSQL_USER="bookstack"
MYSQL_PASS="p4ssword" 
MYSQL_DB="bookstack"

# Set backup directory
BACKUP_DIR="/home/anton/sql_backup/bookstack"

# Restore each table
for table_backup in $BACKUP_DIR/*.gz
do
  table_name=$(basename $table_backup .gz)
  
  # Uncompress backup
  gunzip -c $table_backup > $table_name.sql
  
  # Restore table
  mysql -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB < $table_name.sql
  
  # Remove uncompressed backup
  rm $table_name.sql
done
