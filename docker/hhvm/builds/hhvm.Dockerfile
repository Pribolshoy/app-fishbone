FROM hhvm/hhvm-proxygen:3.30.12

ARG HOST_UID=1001

# часовой пояс МСК
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime

# ADD ./ /var/www
# RUN rm -rf /var/www

COPY ./docker/hhvm/bin/hhvm.sh /start.sh

RUN chmod +x /start.sh

STOPSIGNAL SIGQUIT

