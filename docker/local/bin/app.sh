#!/usr/bin/env bash

# тестируем подключения к БД

connectstring="host=$POSTGRESQL_HOST dbname=$POSTGRESQL_DB_NAME user=$POSTGRESQL_USERNAME password=$POSTGRESQL_PASS"
echo $connectstring;

while php -r "if(pg_connect('$connectstring')){echo 'Database server is ready. Connected.';exit(1);}else{exit(0);}"; do
  >&2 echo "Database server is unavailable - sleeping"
  sleep 1
done

# запуск phpfpm
php-fpm -F --pid /opt/bitnami/php/tmp/php-fpm.pid -y /opt/bitnami/php/etc/php-fpm.conf