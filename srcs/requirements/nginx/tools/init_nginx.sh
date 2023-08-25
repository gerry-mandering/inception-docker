#!/bin/bash

# symbolic linking logs
ln -sf /dev/stdout /var/log/nginx/access.log && \
ln -sf /dev/stderr /var/log/nginx/error.log

# generate openssl certificate
mkdir -p $CERTS_
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout $CERTS_/$DOMAIN_NAME.key \
        -out $CERTS_/$DOMAIN_NAME.crt \
        -subj "/C=KR/L=Seoul/O=42Seoul/CN=$DOMAIN_NAME" \
        > /dev/null 2>&1

# execute nginx
nginx -g "daemon off;"