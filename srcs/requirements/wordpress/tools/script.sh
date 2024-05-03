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


echo "check if wordpress is installed"
wp --info
cd /var/www/html/

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

echo "Adding secrets to wp-config.php"
cat << 'EOF' >> /var/www/html/wp-config.php
    define('AUTH_KEY',         'J1fU90>,#E:F^&2&Ay]x2@UZbH.F`T#vM?C$BNj8B1lTJQ;60NmEWhDs>Hhd 8)l');
    define('SECURE_AUTH_KEY',  '@0u$F7/FpDqV[f>*mvYc4DH>lN[sLrdqVHg-R*aC_?fYp}&h^Tq=D(,F(JD+iwxV');
    define('LOGGED_IN_KEY',    'AoCrl|28rzx*X;$vr9VpxmaOXJ0Ro gY+H2++|w<{q~3F|6?5y8R(8mQl,,Cft?^');
    define('NONCE_KEY',        '{I3:_.+9-IX+*-:K^>++?%f|=+:55>->E`y<f(7W1(+elDo-A _q9jtnBZBfPH8:');
    define('AUTH_SALT',        '^t8Qr[O6h**|h=7H|+6(:Gg>x6kxV3aeL+P(RJ|.@W]iZ[Iu+W91W16spEq4xjdc');
    define('SECURE_AUTH_SALT', '_;}u[)Tg(y.-t0VY|e$EigS#:}QNr-<~GzR:-|a%zm2,;G,]d9PO-{?A%vk)~MI%');
    define('LOGGED_IN_SALT',   'Qo%gwfFpX{23diX}vS_p1EPaQVG4Ep/(%j:Ap!6*M5y3u%ou66b<x5:p)x^sKRk0');
    define('NONCE_SALT',       '0vTf>4a91mCkw7s)ez`*%jGHx~D|xq0X!n|,Z/2[{+?@]t/|`plBx`Pu5jw6@_y&');
EOF
echo "done with the secrets, now starting php-fpm"


touch /var/www/html/lock
chown -R www-data:www-data /var/www/
chmod -R 777 /var/www/html

php-fpm7.4 -F