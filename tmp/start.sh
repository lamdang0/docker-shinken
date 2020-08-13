#!/bin/sh

chown -R shinken:shinken /etc/shinken/*
chmod 755 /usr/lib64/nagios/plugins/*

service nrpe start
service shinken start 
#tail -f /dev/null

exec "$@"
