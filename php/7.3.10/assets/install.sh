#!/bin/sh

mkdir -p /run/nginx
mkdir -p /etc/nginx/sites-enabled
# cp ${NGINX_BUILD_ASSETS_DIR}/config/nginx.conf ${NGINX_BUILD_ROOT_DIR}/etc/nginx/nginx.conf
# cp ${NGINX_BUILD_ASSETS_DIR}/config/sites-enabled/default ${NGINX_BUILD_ROOT_DIR}/etc/nginx/sites-enabled/default
cp ${NGINX_BUILD_ASSETS_DIR}/config/nginx.conf /etc/nginx/nginx.conf
cp ${NGINX_BUILD_ASSETS_DIR}/config/sites-enabled/default /etc/nginx/sites-enabled/default