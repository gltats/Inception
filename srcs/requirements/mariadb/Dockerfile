FROM debian:11.8

RUN apt-get update && apt-get install -y \
    mariadb-server \
    nano \
    && rm -rf /var/lib/apt/lists/*

# RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/sofia.conf /etc/mysql/my.cnf

# COPY tools/init.sql /
COPY tools/entrypoint.sh /
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
# ENTRYPOINT ["/bin/bash"]
# CMD /bin/bash