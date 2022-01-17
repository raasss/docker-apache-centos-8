FROM centos:8

ENV PHP_FPM_SERVER php-fpm-server
ENV PHP_FPM_PORT 9000
ENV PHP_FPM_PING_URL /ping
ENV PHP_FPM_STATUS_URL /status

RUN set -e; \
    yum makecache; \
    yum -y install epel-release; \
    yum -y upgrade; \
    yum -y install \
        tini \
        httpd \
        mod_fcgid; \
    yum -y clean all

RUN set -e; \
    cd /var/log; \
    rm -rvf httpd; \
    mkdir -v -m 0750 httpd; \
    chown -v root:adm httpd; \
    cd httpd; \
    ln -s /dev/stdout access.log; \
    ln -s /dev/stderr error.log

COPY servername.conf /etc/httpd/conf.d/servername.conf

COPY 000-default.conf /etc/httpd/conf.d/000-default.conf
RUN set -e; \
    chmod -v 0644 /etc/httpd/conf.d/000-default.conf; \
    chown -v root:root /etc/httpd/conf.d/000-default.conf

VOLUME [ "/var/www/html" ]

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 0755 /docker-entrypoint.sh

ENTRYPOINT ["tini", "--"]
CMD ["/docker-entrypoint.sh"]
