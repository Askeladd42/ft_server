#!/bin/bash

if [ $AUTOINDEX = ON ]; then
	mv /tmp/nginx_on.conf /etc/nginx/sites-available/localhost/nginx.conf
else
	mv /tmp/nginx_off.conf /etc/nginx/sites-available/localhost/nginx.conf
fi

service nginx start
service mysql start
service php7.3-fpm start

bash