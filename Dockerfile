FROM gliderlabs/alpine
MAINTAINER Māris Vilks <maris.vilks@bigdog.io>
LABEL Description="gliderlabs/alpine based image running collectd daemon with 'network' plugin and 'mysql' plugin."

RUN apk-install \
        bash \
        collectd \
        collectd-mysql \
        collectd-network \
        mysql-client
COPY ./collectd.conf /config/
COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["collectd", "-f", "-C", "/config/collectd.conf"]

