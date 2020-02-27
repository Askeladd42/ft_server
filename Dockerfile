#DDL base image Debian Buster

FROM DEBIAN:BUSTER

# update the software repository
RUN apt-get update

# install nginx + php 7.4.2 + maria-db
RUN apt-get install -y nginx php7.4.2-fpm php7.4.2-gd php7.4.2-mysql php7.4.2-cli \
php7.4.2-common php7.4.2-curl php7.4.2-opcache php7.4.2-json php7.4.2-imap php7.4.2-mbstring php7.4.2-xml

# ENV variables definition
ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php/7.0/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf

# installation database
RUN apt-get install -y mysql-server && -y mysql_secure_installation

# instllation wordpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# creation of a new directory to hold the PHP website :

RUN mkdir /var/www/(my_domain)