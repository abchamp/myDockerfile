# FROM ubuntu:18.04
FROM alpine:3.10.2

LABEL maintainer="NGINX PHP Docker Maintainers"

ENV NGINX_BUILD_ASSETS_DIR=/var/lib/docker-nginx \
    NGINX_BUILD_ROOT_DIR=/var/lib/docker-nginx/rootfs
# install
RUN apk update && apk add --virtual build-dependencies pcre libbz2 ca-certificates libressl \
    rm /var/cache/apk/*
# RUN apt-get install nginx
# install php 7.3.10
RUN apk add nginx
# copy sites-available
ENV NGINX_USER=www-data \
    NGINX_SITECONF_DIR=/etc/nginx/sites-enabled \
    NGINX_LOG_DIR=/var/log/nginx \
    NGINX_TEMP_DIR=/var/lib/nginx

COPY assets/ ${NGINX_BUILD_ASSETS_DIR}/
RUN chmod +x ${NGINX_BUILD_ASSETS_DIR}/install.sh
RUN ${NGINX_BUILD_ASSETS_DIR}/install.sh
RUN adduser -S -G www-data www-data

RUN mkdir -p /usr/share/nginx/html
COPY index.html /usr/share/nginx/html
RUN chown -R www-data:www-data /usr/share/nginx/html
RUN chown -R 770 /usr/share/nginx/html

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 80/tcp 443/tcp

# STOPSIGNAL SIGTERM 

CMD ["/usr/local/bin/run.sh"]