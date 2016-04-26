FROM gliderlabs/alpine
MAINTAINER Māris Vilks <maris.vilks@bigdog.io>
LABEL Description="gliderlabs/alpine based image running collectd daemon with 'network' plugin and 'mysql' plugin. Configuration file should be feeded form outside (e.g. docker-compose volumes)."

RUN apk-install \
        collectd \
        collectd-mysql \
        collectd-network \
        mysql-client

ENTRYPOINT ["collectd"]

