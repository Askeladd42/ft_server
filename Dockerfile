#DDL base image Debian Buster

FROM debian:buster
LABEL maintainer="plam plam@student.42.fr"

# update the software repository
RUN apt-get update && apt-get -y upgrade

# install nginx + maria-db
RUN apt-get install -y nginx
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y mariadb-server

# install php 7.4.2

RUN apt-get install php7.4.2-fpm php7.4.2-gd php7.4.2-mysql php7.4.2-cli \
php7.4.2-common php7.4.2-curl php7.4.2-opcache php7.4.2-json php7.4.2-imap php7.4.2-mbstring php7.4.2-xml

#install wordpress
RUN cd /tmp \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar -zxvf latest.tar.gz \
	&& mv wordpress/ /var/www/html/wordpress \
	&& chown -R www-data:www-data /var/www/html/wordpress \
	&& chmod 755 -R /var/www/html/wordpress/

#install phpmyadmin

RUN cd /tmp \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& rm phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& mv phpMyAdmin* /var/www/html/phpmyadmin \
	&& chown -R www-data:www-data /var/www/html/phpmyadmin \ 
	&& chmod 777 /var/www/html/phpmyadmin

# ENV variables definition
ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php/7.0/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf

# installation database
RUN apt-get install -y mysql-server && -y mysql_secure_installation

# creation of a new directory to hold the PHP website :

RUN mkdir /var/www/muh_domain
RUN mkdir -p /run/php && \
	chown -R $USER:$USER /var/www/muh_domain && \
	chown -R www-data:www-data /run/php

# nginx config

COPY srcs/nginx.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

# phpMyAdmin configuration

COPY srcs/phpmyadmin-config.php /var/www/html/phpmyadmin

# wordpress configuration

COPY srcs/wp-config.php /var/www/html/wordpress
COPY srcs/wordpress_database.sql /tmp

# SSL creation

COPY srcs/localhost.key /etc/ssl/private/nginx-cert.key
COPY srcs/localhost.crt /etc/ssl/certs/nginx-cert.crt

# starting the server

CMD service nginx start \
		&& service mysql start \
		&& service php7.4.2-fpm start && tail -f /dev/null