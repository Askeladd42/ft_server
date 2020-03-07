#!/bin/bash

ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

if [AUTOINDEX = ON]; then
	mv srcs/nginx_on.conf /etc/nginx/sites-available/localhost/nginx.conf
else
	mv srcs/nginx_off.conf /etc/nginx/sites-available/localhost/nginx.conf
fi

service nginx start
service mysql start
service php7.3-fpm start

bash