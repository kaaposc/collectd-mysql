#!/bin/bash

DEF_MYSQL_PORT=3306
DEF_NETWORK_PORT=25826
CONFIG_FILE="/config/collectd.conf"

print_head ()
{
	read -d '' head <<- EOF
		Hostname "collectd"
		FQDNLookup false

		LoadPlugin "mysql"
		LoadPlugin "network"

		<Plugin "mysql">
EOF
	echo "$head" > $CONFIG_FILE
}

print_item ()
{
	read -d '' item <<- EOF
		<Database "$1">
			Host "$2"
			User "$3"
			Password "$4"
			Port "${5:-$DEF_MYSQL_PORT}"
		</Database>
EOF
	echo "$item" >> $CONFIG_FILE
}

print_tail ()
{
	read -d '' _tail <<- EOF
		</Plugin>
		<Plugin "network">
			Server "$NETWORK_SERVER" "${NETWORK_PORT:-$DEF_NETWORK_PORT}"
		</Plugin>
EOF
	echo "$_tail" >> $CONFIG_FILE
}


print_head

if [ ! -z "$MYSQL_SERVER" ]; then
	print_item "$MYSQL_SERVER" "$MYSQL_HOST" "$MYSQL_USER" "$MYSQL_PASSWORD" "$MYSQL_PORT"
fi

ITEM=1
while [ 1 ]; do
	DB="MYSQL_${ITEM}_SERVER"
	HOST="MYSQL_${ITEM}_HOST"
	USER="MYSQL_${ITEM}_USER"
	PASSWORD="MYSQL_${ITEM}_PASSWORD"
	PORT="MYSQL_${ITEM}_PORT"
	if [ ! -z "${!DB}" ]; then
		print_item "${!DB}" "${!HOST}" "${!USER}" "${!PASSWORD}" "${!PORT}"
	else
		break
	fi
	((ITEM++))
done

print_tail

exec "$@"

