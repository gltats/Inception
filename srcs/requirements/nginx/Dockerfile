FROM debian:11


RUN apt-get update && apt-get install -y \
    nginx nano \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/sofia.html /var/www/html/
COPY ./conf/sofia.conf /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]