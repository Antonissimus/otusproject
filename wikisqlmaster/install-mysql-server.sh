#!/bin/bash

# Get the current user running the script
SCRIPT_USER="${SUDO_USER:-$USER}"

# Get the current machine IP address
CURRENT_IP=$(ip addr | grep 'state UP' -A4 | grep 'inet ' | awk '{print $2}' | cut -f1  -d'/')

# Generate a password for the database
DB_PASS="r9PFbhQQ7kwVA"


# Set up database
function run_database_setup() {
  # Create the required user database, user and permissions in the database
  mysql -u root --execute="CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';"
  mysql -u root --execute="GRANT REPLICATION SLAVE ON *.* TO repl@'%';"
}

run_database_setup 