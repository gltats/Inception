FROM debian:11

RUN apt-get update && apt-get install -y \
    openssl \
    gettext \
    nginx nano \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/sofia.html /var/www/html/
COPY ./tools/library.html /var/www/html/
COPY ./conf/sofia.conf /etc/nginx/sites-enabled/sofia.conf
COPY ./tools/generate_cert.sh /generate_cert.sh
RUN chmod +x /generate_cert.sh

# Generate the certificate and key, then set their permissions
RUN /generate_cert.sh && chmod 644 /etc/ssl/certs/cert.pem /etc/ssl/private/key.pem

CMD /bin/bash -c "/generate_cert.sh && cat /etc/nginx/sites-enabled/sofia.conf && exec nginx -g 'daemon off;'"

# envsubst substitutes the environment variables in the template file and create the actual configuration file
# CMD /bin/bash -c "/generate_cert.sh && envsubst '\$SSL_CERTIFICATE \$SSL_CERTIFICATE_KEY' < /etc/nginx/sites-enabled/sofia.conf.template > /etc/nginx/sites-enabled/sofia.conf && exec nginx -g 'daemon off;'"
# CMD /bin/bash -c "/generate_cert.sh && echo \$SSL_CERTIFICATE \$SSL_CERTIFICATE_KEY && envsubst '\$SSL_CERTIFICATE \$SSL_CERTIFICATE_KEY' < /etc/nginx/sites-enabled/sofia.conf.template > /etc/nginx/sites-enabled/sofia.conf && exec nginx -g 'daemon off;'"
# CMD /bin/bash -c "/generate_cert.sh && echo \$SSL_CERTIFICATE \$SSL_CERTIFICATE_KEY && envsubst '\$SSL_CERTIFICATE \$SSL_CERTIFICATE_KEY' < /etc/nginx/sites-enabled/sofia.conf.template > /etc/nginx/sites-enabled/sofia.conf && cat /etc/nginx/sites-enabled/sofia.conf && exec nginx -g 'daemon off;'"
# CMD /bin/bash -c "/generate_cert.sh && envsubst '\$SSL_CERTIFICATE \$SSL_CERTIFICATE_KEY' < /etc/nginx/sites-enabled/sofia.conf.template > /etc/nginx/sites-enabled/sofia.conf && nginx -g 'daemon off;' || tail -f /dev/null"