FROM hhvm/hhvm-proxygen:3.30.12

ARG HOST_UID=1001

COPY ./docker/hhvm/bin/hhvm.sh /start.sh

RUN chmod +x /start.sh

STOPSIGNAL SIGQUIT

