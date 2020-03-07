#!/bin/bash

if [ $AUTOINDEX = ON ]; then
	mv /tmp/nginx_on.conf /etc/nginx/sites-available/localhost
else
	mv /tmp/nginx_off.conf /etc/nginx/sites-available/localhost
fi

service nginx start
service mysql start
service php7.3-fpm start
tail -f /dev/null