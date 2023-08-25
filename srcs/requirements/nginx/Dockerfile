FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl dumb-init

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/init_nginx.sh /init_nginx.sh

EXPOSE 433

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/init_nginx.sh"]
