#!/bin/bash
trap "exit" TERM

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"$MYSQL_HOSTNAME" --silent; do
    echo "MariaDB is unavailable - waiting..."
    sleep 2
done

echo "MariaDB is up - continuing with setup..."

until mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$(< /run/secrets/mysql_pw)" -e "SELECT 1;" &> /dev/null; do
    echo "Waiting for MariaDB to grant privileges to user '$MYSQL_USER'..."
    sleep 2
done

WP_PATH="/var/www/wordpress"

cd /var/

echo "wp config create......."
wp config create --allow-root \
                --dbname=$MYSQL_DATABASE \
				--dbuser=$MYSQL_USER \
                --dbpass=$(<"/run/secrets/mysql_pw") \
				--dbhost=$MYSQL_HOSTNAME:3306 \
                --path=$WP_PATH

echo "wp core install......."
wp core install --allow-root \
            --url=$DOMAIN_NAME \
            --title='inception' \
            --admin_user=$WP_ADMIN \
            --admin_password=$(<"/run/secrets/wp_admin_pw") \
            --admin_email='random@42berlin.com' \
            --skip-email \
            --path=$WP_PATH

echo "wp user create........"
wp user create --allow-root \
            $WP_USER random@gmx.de \
			--user_pass=$(<"/run/secrets/wp_user_pw") \
            --path=$WP_PATH

directory="/run/php"

if [ ! -d "$directory" ]; then
    mkdir -p $directory
    echo "Directory $directory created successfully."
else
    echo "Directory $directory already exists."
fi

echo "launch php..."
exec /usr/sbin/php-fpm7.4 -F