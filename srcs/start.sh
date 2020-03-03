#!/bin/bash
service nginx start
service mysql start
service php7.3-fpm start
nginx -g 'daemon off;'
tail -f /dev/null

bash