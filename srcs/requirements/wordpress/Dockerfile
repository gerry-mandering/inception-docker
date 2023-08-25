FROM debian:bullseye-slim

RUN apt-get update \
    && apt-get install -y wget php7.4 php7.4-curl php7.4-imagick php7.4-xml php7.4-zip php7.4-xmlreader php7.4-ssh2 php7.4-gd php7.4-fpm php7.4-mysql mariadb-client

RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress/* . && \
    rm -r wordpress && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]