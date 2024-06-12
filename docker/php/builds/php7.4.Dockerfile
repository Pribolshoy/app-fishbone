FROM bitnami/php-fpm:7.4

ARG HOST_UID=1001

RUN apt-get update -y
RUN apt-get install -y gcc make autoconf composer npm \
    supervisor nano-tiny cron

RUN npm install -g gulp-cli

RUN apt-get install php-pgsql -y \
    && pecl install redis \
    && pecl install pcov \
    && pecl install ast \
    && echo "extension=ast.so" > /opt/bitnami/php/etc/conf.d/ast.ini \
    && echo "extension=redis.so" > /opt/bitnami/php/etc/conf.d/redis.ini \
    && echo "extension=pgsql.so" > /opt/bitnami/php/etc/conf.d/pgsql.ini \
    && echo "extension=pcov.so" > /opt/bitnami/php/etc/conf.d/pcov.ini \
    && echo "extension=pdo_pgsql.so" > /opt/bitnami/php/etc/conf.d/pdo_pgsql.ini

# Устанавливаем Pinba
RUN git clone https://github.com/tony2001/pinba_extension.git \
    && cd pinba_extension \
    && phpize \
    && ./configure --enable-pinba \
    && make install

# часовой пояс МСК
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

COPY ./app/ /app

RUN \
    export COMPOSER_MEMORY_LIMIT=-1 \
    && usermod -u ${HOST_UID} www-data \
    && usermod -s /bin/bash www-data  \
#    && usermod -aG root www-data  \
    && cd /app
#    && composer install

COPY ./docker/main/bin/app.sh /start.sh

RUN chmod +x /start.sh

COPY ./docker/main/conf/app/common.conf /opt/bitnami/php/etc/common.conf

STOPSIGNAL SIGQUIT

