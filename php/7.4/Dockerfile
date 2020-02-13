# https://hub.docker.com/_/php/
# https://khasathan.in.th/archives/351/%E0%B8%9A%E0%B8%B1%E0%B8%99%E0%B8%97%E0%B8%B6%E0%B8%81%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%95%E0%B8%B4%E0%B8%94%E0%B8%95%E0%B8%B1%E0%B9%89%E0%B8%87-phpfpm-%E0%B8%A3%E0%B9%88%E0%B8%A7%E0%B8%A1%E0%B8%81%E0%B8%B1%E0%B8%9A-apache2

FROM php:fpm-alpine

RUN apk add --no-cache \
        zlib \
        libjpeg-turbo-dev \
        libpng-dev \
        freetype-dev \
        libmcrypt-dev \
        libzip-dev \
		openssl-dev

RUN apk add --update --no-cache --virtual .docker-php-mongodb-dependancies heimdal-dev

RUN docker-php-ext-configure gd \
        --with-jpeg \
        --with-freetype

RUN	docker-php-ext-install gd \
                    pdo_mysql \
                    zip \
                    opcache

RUN apk add --no-cache --virtual .build-deps \
        autoconf \
		g++ \
		gcc \
		make \
    && pecl install mcrypt-1.0.3 \ 
	&& docker-php-ext-enable mcrypt \
    && apk del .build-deps

# XDEBUG
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug-2.9.2 \
    && docker-php-ext-enable xdebug

# Mongo
RUN apk add --no-cache --virtual .build-deps \
        autoconf \
		g++ \
		gcc \
		make \
    && pecl install mongodb-1.6.1 \
    && docker-php-ext-enable mongodb \
    && apk del .build-deps

ADD php.ini /usr/local/etc/php/conf.d
ADD www.conf /usr/local/etc/php-fpm.d/www.conf
ADD supervisord.conf /etc/supervisord.conf

#install composer
RUN curl -s http://getcomposer.org/installer | php && mv ./composer.phar /usr/local/bin/composer

#install nginx
RUN apk add nginx
COPY nginx.conf /etc/nginx/nginx.conf

#supervisor
RUN apk add --no-cache supervisor

EXPOSE 443 80

STOPSIGNAL SIGTERM

WORKDIR /var/www/html

CMD ["supervisord", "-c", "/etc/supervisord.conf"]