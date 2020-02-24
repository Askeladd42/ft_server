#DDL base image Debian Buster

FROM DEBIAN:BUSTER

# update the software repository
RUN apt-get update

# install nginx + php 7.4.2
RUN apt-get install -y nginx php7.4.2-fpm php7.4.2-gd php7.4.2-mysql php7.4.2-cli php7.4.2-common php7.4.2-curl php7.4.2-opcache php7.4.2-json php7.4.2-imap php7.4.2-mbstring php7.4.2-xml

# installation database
RUN apt-get install mysql-server