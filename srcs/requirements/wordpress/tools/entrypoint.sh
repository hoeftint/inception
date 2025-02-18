#!/bin/bash
trap "exit" TERM

sleep 20

WP_PATH="/var/www/wordpress"

cd /var/

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