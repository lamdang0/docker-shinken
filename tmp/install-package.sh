#!/bin/sh
set -euo pipefail

SHINKEN_DOWNLOAD_URL="https://github.com/naparuba/shinken/archive/2.4.3.tar.gz"
LOG_DIR="/var/log/shinken"
DATA_DIR="/var/lib/shinken"
CONFIG_DIR="/etc/shinken"
CONFIG_FILE="/etc/shinken/shinken.cfg"
TEMP_CONF_FILE="/root/tmp/shinken.cfg"
PWD="/tmp"

yum install -y epel-release
yum install -y python-setuptools
#yum install -y wget redhat-lsb python-crypto mongodb mongodb-server httpd-tools openssl
yum install -y wget redhat-lsb python-crypto mongodb mongodb-server httpd-tools openssl

yum install -y python-pycurl python-pip python-cherrypy nrpe nagios-plugins-all perl-Sys-Statistics-Linux

adduser -d /nonexistent -s /sbin/nologin shinken
# Download source && build shinken
# 
cd $PWD
wget $SHINKEN_DOWNLOAD_URL
tar -xvzf $SHINKEN_VERSION.tar.gz
cd shinken-$SHINKEN_VERSION
python setup.py install

#Install requirement from list with pip and initialize.
#pip install -r https://raw.githubusercontent.com/shinken-monitoring/mod-webui/develop/requirements.txt
shinken --init

shinken install webui
shinken install simple-log
shinken install sqlitedb
shinken install auth-cfg-password
shinken install graphite


sed -i -e "s@dont_blame_nrpe=0@dont_blame_nrpe=1@g" /etc/nagios/nrpe.cfg
sed -i -e '$a\nrpe            5666/tcp\' /etc/services


rm -rf /tmp/$SHINKEN_VERSION.tar.gz
rm -rf /tmp/shinken-$SHINKEN_VERSION

yum remove -y epel-release python-setuptools

# Add user
chown -R shinken:shinken $CONFIG_DIR
chown -R shinken:shinken $LOG_DIR

#Preparing scripts
chmod +x /root/tmp/docker-entrypoint.sh
ln -sf /root/tmp/docker-entrypoint.sh /docker-entrypoint.sh

chmod +x /root/tmp/start.sh
ln -sf /root/tmp/start.sh /start

chmod +x /root/tmp/restart.sh
ln -sf /root/tmp/restart.sh /restart

chmod +x /root/tmp/stop.sh
ln -sf /root/tmp/stop.sh /stop

chmod +x /root/tmp/reload.sh
ln -sf /root/tmp/reload.sh /reload

exit 0
