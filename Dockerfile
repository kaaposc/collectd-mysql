FROM debian
MAINTAINER Māris Vilks <maris.vilks@bigdog.io>
LABEL Description="Debian based image with collectd daemon, 'network' plugin and mysql client libraries for 'mysql' plugin."

# MYSQL_PORT and NETWORK_PORT can be omitted if set to default values
ENV MYSQL_HOST="mysql" \
    MYSQL_PORT="3306" \
    MYSQL_USER="mysql" \
    MYSQL_PASSWORD="password" \
    NETWORK_SERVER="logstash" \
    NETWORK_PORT="25826"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        collectd-core \
        libmysqlclient18 \
        librrd4- perl- \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY ./collectd.conf /config/
COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["collectd", "-f", "-C", "/config/collectd.conf"]

