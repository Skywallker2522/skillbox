FROM alpine:3.18

# Пакетлар
RUN apk add --no-cache \
    nginx \
    openrc \
    python3 \
    py3-pip

# Python пакетлар
RUN pip3 install setuptools testinfra pytest

# nginx папка
RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/test

# test файлни контейнерга қўшиш
COPY test.py /etc/nginx/test/test.py
COPY default.conf /etc/nginx/http.d/default.conf
COPY index.html /var/www/localhost/htdocs/index.html
# nginx конфиг (агар бор бўлса)
#COPY . /var/www/localhost/htdocs/

# тестларни ишга тушириш
RUN pytest /etc/nginx/test/test.py

# порт
EXPOSE 80

# nginx старт
CMD ["nginx", "-g", "daemon off;"]
