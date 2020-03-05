#!/bin/bash

service nginx start \
&& service mysql start \
&& mysql -u root -e "CREATE DATABASE wordpress_database" \
	&& mysql -u root -e "CREATE USER 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress_database.* TO 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'plam'@'localhost' IDENTIFIED BY 'oof'" \
	&& mysql -u root -e "FLUSH PRIVILEGES" \
	&& mysql wordpress_database < /tmp/wordpress_database.sql\
&& service php7.3-fpm start

bash