#!/bin/bash
# req is the OpenSSL utility for generating a CSR (Certificate Signing Request).
# -x509 tells req to create a self-signed certificate.
# -newkey rsa:4096 creates a new 4096-bit RSA key.
# -keyout key.pem specifies the output filename for the private key.
# -out cert.pem specifies the output filename for the certificate.
# -days 365 specifies that the certificate will be valid for 365 days.

echo "Generating certificate and key..."
openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/key.pem -out /etc/ssl/certs/cert.pem -days 365 -nodes -subj "/CN=localhost"
echo "Done."

echo "Listing /etc/ssl/certs and /etc/ssl/private..."
ls -l /etc/ssl/certs
ls -l /etc/ssl/private
echo "Done."