FROM debian
#FROM php:8.2-apache
#RUN rm /etc/apt/preferences.d/no-debian-php
RUN sed -i 's/http:/https:/g' /etc/apt/sources.list.d/debian.sources
RUN echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/99ignore-ssl-certificates
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php mariadb-client php-mysql   && apt-get clean && rm -rf /var/lib/apt/lists/* 
RUN a2enmod rewrite && a2enmod php8.2
RUN sed -i '172s/.*/AllowOverride All/' /etc/apache2/apache2.conf
RUN rm /var/www/html/index.html

#RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

COPY ./src/ /var/www/html/
COPY ./script.sh /usr/local/
COPY ./src/database.sql /opt/
ENV BASE_URL 'http://prueba.javiercd.es'
ENV DB_USER javiercruces
ENV DB_PASS javiercruces
ENV DB_NAME javiercruces
ENV DB_HOST mariadb-prueba

RUN chmod +x /usr/local/script.sh

CMD /usr/local/script.sh

