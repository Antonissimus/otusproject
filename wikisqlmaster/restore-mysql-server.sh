#!/bin/bash

# Create the required user database, user and permissions in the database
mysql -u root --execute="CREATE DATABASE bookstack;"

mysql -u root --execute="CREATE USER 'bookstack'@'localhost' IDENTIFIED WITH mysql_native_password BY 'p4ssword';"
mysql -u root --execute="CREATE USER 'bookstack'@'%' IDENTIFIED WITH mysql_native_password BY 'p4ssword';"

mysql -u root --execute="GRANT ALL ON bookstack.* TO 'bookstack'@'localhost';FLUSH PRIVILEGES;"
mysql -u root --execute="GRANT ALL ON bookstack.* TO 'bookstack'@'%';FLUSH PRIVILEGES;"

mysql -u root bookstack < bookstack.backup.sql