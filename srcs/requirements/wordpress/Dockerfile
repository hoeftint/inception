# Pull base image
FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
    apt install php7.4-fpm php7.4-common php7.4-mysql -y

CMD sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/fpm/php.ini

ENTRYPOINT ["/usr/sbin/php-fpm7.4", "-F"]