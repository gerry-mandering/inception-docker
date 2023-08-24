FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 433

CMD ["nginx", "-g", "daemon off;"]
