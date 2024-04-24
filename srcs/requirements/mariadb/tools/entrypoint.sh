#!/bin/bash
rm -rf /var/run/mysqld/*
rm -rf /run/mysqld/*
mkdir -p /var/run/mysqld
mkdir -p /run/mysqld
chown root:root /var/lib/mysql
chown root:root /run/mysqld

/etc/init.d/mariadb start
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS $DBNAME;"
mariadb -u root -e "CREATE USER IF NOT EXISTS '$DBUSER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mariadb -u root -e "FLUSH PRIVILEGES;"
/etc/init.d/mariadb stop
# sleep infinity
exec mysqld
# sleep 2
# mysqld
