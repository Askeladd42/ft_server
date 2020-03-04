#!/bin/bash

fuser -k 80/tcp
service nginx start
service mysql start
service php7.3-fpm start

bash