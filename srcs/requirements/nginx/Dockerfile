# Pull base image
FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
	apt install -y nginx tini

RUN mkdir -p /etc/nginx/ssl && mkdir -p /var/www/html

RUN apt install openssl -y

RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/ssl_cert \
	-keyout /etc/nginx/ssl/ssl_key \
	-subj "/C=DE/ST=Berlin/L=Berlin/O=42 Berlin/OU=42/CN=thofting.42.fr"

# Copy Nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

# Expose HTTPS port
EXPOSE 443

# Start nginx
ENTRYPOINT ["tini", "--", "nginx", "-g", "daemon off;"]