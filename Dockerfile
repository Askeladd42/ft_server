#DDL base image Debian Buster

FROM debian:buster
LABEL maintainer="plam plam@student.42.fr"

# update the software repository
RUN apt update && apt -y upgrade

# install nginx + maria-db (database)
RUN apt install -y nginx wget
RUN DEBIAN_FRONTEND="noninteractive" apt install -y mariadb-server

# install php 7.3

RUN apt install -y php-fpm php-gd php-mysql php-cli \
php-common php-curl php-opcache php-json php-imap php-mbstring php-xml

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
RUN service mysql start \
	&& mysql -u root -e "CREATE DATABASE wordpress_database" \
    && mysql -u root -e "CREATE USER 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress_database.* TO 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'plam'@'localhost' IDENTIFIED BY 'oof'" \
    && mysql -u root -e "FLUSH PRIVILEGES" \
	&& mysql wordpress_database < /tmp/wordpress_database.sql

# SSL creation

COPY srcs/localhost.key /etc/ssl/private/nginx-cert.key
COPY srcs/localhost.crt /etc/ssl/certs/nginx-cert.crt

# starting the server

CMD service nginx start \
		&& service mysql start \
		&& service php7.3-fpm start \
		&& ["nginx", "-g", "daemon off;"]
