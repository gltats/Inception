FROM debian:11

RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

CMD ["MariaDB", "-g", "daemon off;"]