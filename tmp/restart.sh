#!/bin/sh

chown -R shinken:shinken /etc/shinken/*
chmod 755 /usr/lib64/nagios/plugins/*

service shinken restart

exec "$@"

