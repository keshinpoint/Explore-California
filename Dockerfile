FROM nginx
LABEL maintainer="Keshav V <kesavvasudevan@gmail.com>"


COPY ./website  /website
COPY ./website.conf /etc/nginx/nginx.conf
