FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y wget php7.4 php7.4-curl php7.4-imagick php7.4-xml php7.4-zip php7.4-xmlreader php7.4-ssh2 php7.4-gd php7.4-fpm php7.4-mysql mariadb-client dumb-init

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]