FROM alpine:3.10

ENV TZ Asia/Bangkok
ENV APACHE_CONF_DIR=/etc/apache2/ \
    PHP_CONF_DIR=/etc/php/5.6 \
    PHP_DATA_DIR=/var/lib/php

COPY ./app /var/www/app/
COPY entrypoint.sh /sbin/entrypoint.sh

# RUN echo "ipv6" >> /etc/modules
# RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories; \
    # echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories
RUN apk add --update --no-cache alpine-sdk

RUN apk update && apk add --no-cache  --repository http://dl-cdn.alpinelinux.org/alpine/v3.8/community \
        tzdata curl apache2 php5 \ 
        php5-bcmath \
        php5-dom \ 
        php5-ctype \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-iconv \
        php5-intl \
        php5-json \
        php5-mcrypt \
        php5-opcache \
        php5-openssl \
        php5-pdo \
        php5-pdo_mysql \
        php5-pdo_pgsql \
        php5-pdo_sqlite \
        php5-phar \
        php5-posix \
        php5-soap \
        php5-xml \
	    php5-zip \
	    php5-zlib \
        php5-cli \
    && rm -rf /var/cache/apk/* \
    # apache setting
    && cp /dev/null ${APACHE_CONF_DIR}/conf-available/other-vhosts-access-log.conf \
    && rm ${APACHE_CONF_DIR}/site-enabled/000-default.conf ${APACHE_CONF_DIR}/sites-available/000-default.conf \
    && a2enmod rewrite php5.6 \
    # php setup
    # Install composer
	&& curl -sS https://getcomposer.org/installer | php -- --version=1.6.4 --install-dir=/usr/local/bin --filename=composer \
	# Cleaning
	# Forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/apache2/access.log \
	&& ln -sf /dev/stderr /var/log/apache2/error.log \
	&& chmod 755 /sbin/entrypoint.sh \
    && chown www-data:www-data ${PHP_DATA_DIR} -Rf

COPY ./configs/apache2.conf ${APACHE_CONF_DIR}/apache2.conf
COPY ./configs/app.conf ${APACHE_CONF_DIR}/sites-enabled/app.conf
COPY ./configs/php.ini  ${PHP_CONF_DIR}/apache2/conf.d/custom.ini

WORKDIR /var/www/app/

EXPOSE 80 443
CMD ["/sbin/entrypoint.sh"]
