FROM nginx
LABEL maintainer="Keshav V <kesavvasudevan@gmail.com>"


COPY ./website  /website
COPY ./website /usr/share/nginx/html

EXPOSE 8080
