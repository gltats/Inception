FROM debian:11

RUN	apt-get update && apt-get install -y \
	php-fpm \
	php-mysqlnd \
	php-cgi \
	mariadb-client \
	nano \
	wget \
	unzip \
	bash \
	sendmail \
	curl \
	iptables \
	findutils && \
	rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir /run/php

COPY ./tools/script.sh /

# RUN mkdir -p /var/www/html 
# COPY ./tools/wp-config.php /var/www/html/

RUN chmod 777 /script.sh

ENTRYPOINT [ "/script.sh" ]
