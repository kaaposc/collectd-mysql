#!/bin/bash

mysql_host=$MYSQL_HOST
def_mysql_port=3306
mysql_port=${MYSQL_PORT:-$def_mysql_port}
mysql_user=$MYSQL_USER
mysql_pass=$MYSQL_PASSWORD
network_server=$NETWORK_SERVER
def_network_port=25826
network_port=${NETWORK_PORT:-$def_network_port}
config_file="/config/collectd.conf"

sed -i "s/\$MYSQL_HOST/$mysql_host/g" $config_file
sed -i "s/\$MYSQL_USER/$mysql_user/g" $config_file
sed -i "s/\$MYSQL_PASSWORD/$mysql_pass/g" $config_file
sed -i "s/\$MYSQL_PORT/$mysql_port/g" $config_file
sed -i "s/\$NETWORK_SERVER/$network_server/g" $config_file
sed -i "s/\$NETWORK_PORT/$network_port/g" $config_file

exec "$@"

