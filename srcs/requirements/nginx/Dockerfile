FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 433

CMD ["nginx", "-g", "daemon off;"]
