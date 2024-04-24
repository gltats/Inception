FROM debian:11

RUN apt-get update && apt-get install -y \
    php7.3-fpm \
	php7.3-mysql \
	mariadb-client \
    nano \
	curl && \
	rm -rf /var/lib/apt/lists/*

COPY ./tools/script.sh /
COPY ./tools/wp-config.php /


CMD [ "/script.sh" ]