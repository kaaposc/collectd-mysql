# collectd-mysql

`gliderlabs/alpine` based docker image running collectd daemon with `mysql`
and `network` plugins.

Entrypoint script uses environment variables to create `collectd.conf` file. If
only one MySQL server needs to be monitored, define env variables `MYSQL_SERVER_NAME`, 
`MYSQL_HOST`, `MYSQL_USER` and `MYSQL_PASSWORD`. Variable `MYSQL_PORT` can be 
omitted if server runs on default 3306 port.

In case of multiple MySQL servers monitoring define variables `MYSQL_1_SERVER_NAME`,
`MYSQL_1_HOST`, `MYSQL_1_USER`, `MYSQL_1_PASSWORD` for first server, 
`MYSQL_2_SERVER_NAME`, `MYSQL_2_HOST`, `MYSQL_2_USER`, `MYSQL_2_PASSWORD` for the
second _et cetera_. `MYSQL_${I}_PORT` also can be omitted if set to default.

If using this image in docker-compose scenario, it's best to use envfile.

