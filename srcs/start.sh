#!/bin/bash

if [AUTOINDEX = ON]; then
	cp srcs/nginx_on.conf /etc/nginx/sites-available/localhost
else
	cp srcs/nginx_off.conf /etc/nginx/sites-available/localhost
fi

ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

service nginx start
service mysql start
service php7.3-fpm start

bash