#!/bin/bash

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/minseok2.42.fr.key \
    -out /etc/nginx/ssl/minseok2.42.fr.crt \
    -subj "/C=KR/L=Seoul/O=42Seoul/CN=minseok2.42.fr"