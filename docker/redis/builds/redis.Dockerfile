FROM bitnami/redis:7.2.4

RUN mkdir -p /opt/bitnami/redis/mounted-etc
COPY ./docker/redis/conf/redis/redis.conf /opt/bitnami/redis/mounted-etc/redis.conf
