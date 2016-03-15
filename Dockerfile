FROM gliderlabs/alpine:3.1
MAINTAINER Māris Vilks <maris.vilks@bigdog.io>
LABEL Description="Debian based image with collectd daemon, 'network' plugin and mysql client libraries for 'mysql' plugin."

# MYSQL_PORT and NETWORK_PORT can be omitted if set to default values
ENV MYSQL_HOST="mysql" \
    MYSQL_PORT="3306" \
    MYSQL_USER="mysql" \
    MYSQL_PASSWORD="password" \
    NETWORK_SERVER="logstash" \
    NETWORK_PORT="25826"

RUN apk-install \
        bash \
        sed \
        collectd \
        collectd-mysql \
        collectd-network \
        mysql-client
COPY ./collectd.conf /config/
COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["collectd", "-f", "-C", "/config/collectd.conf"]

