#!/bin/sh

#echo reload to apply new configuration

/etc/init.d/shinken reload

exec "$@"

