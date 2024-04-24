#!/bin/bash
rm -rf /var/run/mysqld/*
rm -rf /run/mysqld/*
mkdir -p /var/run/mysqld
mkdir -p /run/mysqld
chown mysql:mysql /var/run/mysqld
chown mysql:mysql /run/mysqld
chmod 755 /var/run/mysqld

/etc/init.d/mariadb start
mariadb -e "CREATE DATABASE IF NOT EXISTS $DBNAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$DBUSER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mariadb -e "FLUSH PRIVILEGES;"
# service mariadb stop
# sleep infinity
exec /etc/init.d/mariadb start
# sleep 2
# mysqld
