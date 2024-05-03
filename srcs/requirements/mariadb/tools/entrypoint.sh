#!/bin/bash
DBNAME=$(cat $DB_NAME_FILE)
DB_HOST=$(cat $DB_HOST_FILE)
DBUSER=$(cat $DB_USER_FILE)
DB_PASSWORD=$(cat $DB_PASSWORD_FILE)

WP_HOST=$(cat $WP_HOST_FILE)
WP_EMAIL=$(cat $WP_EMAIL_FILE)
WP_ADMIN_USER=$(cat $WP_ADMIN_USER_FILE)
WP_ADMIN_PASSWORD=$(cat $WP_ADMIN_PASSWORD_FILE)
WP_ADMIN_EMAIL=$(cat $WP_ADMIN_EMAIL_FILE)

echo "DBNAME: $DBNAME\n"  
echo "DB_HOST: $DB_HOST\n"
echo "DBUSER: $DBUSER\n"
echo "DB_PASSWORD: $DB_PASSWORD\n"
echo "WP_HOST: $WP_HOST\n"
echo "WP_EMAIL: $WP_EMAIL\n"
echo "WP_ADMIN_USER: $WP_ADMIN_USER\n"
echo "WP_ADMIN_PASSWORD: $WP_ADMIN_PASSWORD\n"
echo "WP_ADMIN_EMAIL: $WP_ADMIN_EMAIL\n"

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
