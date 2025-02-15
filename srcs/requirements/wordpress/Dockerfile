# Pull base image
FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
    apt install php7.4-fpm php7.4-common php7.4-mysql tini wget unzip mariadb-client -y

WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && rm latest.zip && \
    chown -R www-data:www-data /var/www

COPY ./conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chown -R root:root /var/www 
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.4/fpm/php.ini

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]