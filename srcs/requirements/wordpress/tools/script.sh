#!/bin/bash
echo "check if wordpress is installed"
wp --info
cd /var/www/html/

if [ -f ./index.php ]
then
    echo "WordPress already downloaded"
else

    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress


	wp core config --dbname=$DBNAME --dbuser=$DBUSER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root
	chown -R www-data:www-data /var/www/html
	chmod 600 wp-config.php
	wp core install --allow-root --url=localhost --title="My site" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
    chown -R www-data:www-data /var/www/html
	chmod 600 wp-config.php
    wp --allow-root user create $DBSER  $WP_EMAIL --role=author
    wp --allow-root user update $DBUSER --user_pass=$DB_PASSWORD --display_name="I_Like_Bacon"
	wp --allow-root --path=/var/www/html theme install generatepress
	wp --allow-root --path=/var/www/html theme activate generatepress
    cp wp-config-sample.php wp-config.php

fi
touch /var/www/html/lock
chown -R www-data:www-data /var/www/
chmod -R 777 /var/www/html
php-fpm7.4 -F

sleep infinity