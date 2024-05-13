#!/bin/bash

# Get the current user running the script
SCRIPT_USER="${SUDO_USER:-$USER}"

# Get the current machine IP address
CURRENT_IP=$(ip addr | grep 'state UP' -A4 | grep 'inet ' | awk '{print $2}' | cut -f1  -d'/')

# Generate a password for the database
DB_PASS="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13)"