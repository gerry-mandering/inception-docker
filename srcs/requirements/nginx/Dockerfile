FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools/generate_certificates.sh ./generate_certificates.sh

RUN chmod +x /generate_certificates.sh && \
    ./generate_certificates.sh

EXPOSE 433

CMD ["nginx", "-g", "daemon off;"]
