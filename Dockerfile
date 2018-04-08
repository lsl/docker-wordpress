FROM lslio/composer:latest as composer

# Installs WordPress into /app/wordpress
RUN composer-require johnpbloch/wordpress:^4.9

# Delete hello dolly
RUN rm /app/wordpress/wp-content/plugins/hello.php

# Create uploads + mu-plugins dirs
# Note: if you don't do this here, later when you
# mount /uploads it will have root permissions
# preventing uploads etc
RUN mkdir /app/wordpress/wp-content/uploads
RUN mkdir /app/wordpress/wp-content/mu-plugins

# Fix write perms, ownership fixed on copy
RUN find /app/wordpress -type d -exec chmod 755 {} \;
RUN find /app/wordpress -type f -exec chmod 644 {} \;

# Build image
FROM alpine:3.7

# Set user
# Note: implicitly creates: /var/www, www group @ gid 1000
# Previously using -G wheel (this might get reverted)
RUN adduser -D -u 1000 -g 1000 -s /bin/sh -h /var/www www-data

# PHP/FPM + Modules
RUN apk add --no-cache --update \
    php7 \
    php7-apcu \
    php7-bcmath \
    php7-bz2 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-fpm \
    php7-ftp \
    php7-gd \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-oauth \
    php7-opcache \
    php7-openssl \
    php7-pcntl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-redis \
    php7-session \
    php7-simplexml \
    php7-tokenizer \
    php7-xdebug \
    php7-xml \
    php7-xmlwriter \
    php7-zip \
    php7-zlib

# tini - 'cause zombies - see: https://github.com/ochinchina/supervisord/issues/60
# gettext - nginx env substitution
RUN apk add --no-cache --update \
    tini \
    gettext \
    nginx && \
    rm -rf /var/www/localhost

# Fix nginx dirs/perms
RUN mkdir -p /var/cache/nginx && \
    chown -R www-data:www-data /var/cache/nginx && \
    chown -R www-data:www-data /var/lib/nginx && \
    chown -R www-data:www-data /var/tmp/nginx

# Install a golang port of supervisord
COPY --from=ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/bin/supervisord

# Runtime env vars are envstub'd into config during entrypoint
# Defaults: proto: http, name: localhost, alias: ''
ENV SERVER_PROTO='http'
ENV SERVER_NAME='localhost'
ENV SERVER_ALIAS=''

# Wordpress config settings
ENV DB_NAME='wordpress'
ENV DB_USER='wordpress'
ENV DB_PASSWORD='wordpress'
ENV DB_HOST='mysql'
ENV WP_DEBUG='false'

# These need to be set in your extending Dockerfile
# `docker run --rm lslio/wordpress salt`
# (its a wrapper around https://api.wordpress.org/secret-key/1.1/salt/)
ENV AUTH_KEY='set me'
ENV SECURE_AUTH_KEY='set me'
ENV LOGGED_IN_KEY='set me'
ENV NONCE_KEY='set me'
ENV AUTH_SALT='set me'
ENV SECURE_AUTH_SALT='set me'
ENV LOGGED_IN_SALT='set me'
ENV NONCE_SALT='set me'

COPY /manifest /

COPY --from=composer --chown=www-data:www-data /app/wordpress /var/www/wordpress

COPY --chown=www-data:www-data wp-config.php /var/www/wordpress/wp-config.php

WORKDIR /var/www/wordpress

EXPOSE 80

ENTRYPOINT ["tini", "--"]
CMD ["/docker-entrypoint.sh"]
