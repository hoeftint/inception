# Pull base image
FROM debian:bullseye

# Install necessary packages
RUN apt update -y && apt upgrade -y && \
    apt-get -y install php7.4 php-fpm php-mysql mariadb-client wget unzip

# Download and unpack WordPress
WORKDIR /var/www
RUN wget https://wordpress.org/latest.zip && \
    unzip latest.zip && rm latest.zip && \
    chown -R www-data:www-data /var/www

# Download WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

