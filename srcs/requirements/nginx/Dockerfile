# Pull base image
FROM debian:latest

# Install nginx and OpenSSL, and adjust nginx config to stay in foreground
RUN apt-get update && \
    apt-get install --no-install-recommends -y nginx openssl && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

# Create SSL directory
RUN mkdir -p /etc/nginx/ssl

# Copy Nginx configuration file
COPY conf/default.conf /etc/nginx/conf.d/

# Copy your website files
COPY www/ /data/www/

# Copy SSL certificates
#COPY ../secrets/nginx.crt /etc/nginx/ssl/nginx.crt
#COPY ../secrets/nginx.key /etc/nginx/ssl/nginx.key

# Expose HTTPS port
EXPOSE 443

# Start nginx
CMD ["/usr/sbin/nginx"]