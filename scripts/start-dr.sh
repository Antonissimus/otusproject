#!/bin/bash

#Restore wikiweb

#rsync nginx config

rsync -avh  ~/otusproject/wikiweb/nginx/default anton@wikiweb:/etc/nginx/sites-available/default