# Pull base image
FROM debian:bullseye

# Install nginx and OpenSSL, and adjust nginx config to stay in foreground
#RUN apt-get update && \
#    apt-get install --no-install-recommends -y nginx openssl tini && \
#    echo "daemon off;" >> /etc/nginx/nginx.conf

RUN apt update -y && apt upgrade -y && apt install -y nginx tini
RUN mkdir -p /etc/nginx/ssl && mkdir -p /var/www/html
RUN apt install openssl -y

# Create SSL directory
#RUN mkdir -p /etc/nginx/ssl

# Copy Nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Copy your website files
COPY ./www/other.html /data/www/other.html

# Copy SSL certificates
# COPY ../../../secrets/nginx.crt /etc/nginx/ssl/nginx.crt
# COPY ../../../secrets/nginx.key /etc/nginx/ssl/nginx.key

# Expose HTTPS port
EXPOSE 443

# Start nginx

ENTRYPOINT  [ "tini", "--", "nginx", "-g", "daemon off;"]

#CMD ["/usr/sbin/nginx"]