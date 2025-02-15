#!/bin/bash
trap "exit" TERM

sleep 20

cd /var/

wp config create --allow-root \
                --dbname=$MYSQL_DATABASE \
				--dbuser=$MYSQL_USER \
                --dbpass=$(<"/run/secrets/mysql_pw") \
				--dbhost=$MYSQL_HOSTNAME:3306 \
                --path="/var/www/wordpress"

echo "wp core install......."
wp core install --allow-root \
            --url=localhost \
            --title='inception' \
            --admin_user=$WP_ADMIN \
            --admin_password=$(<"/run/secrets/wp_admin_pw") \
            --admin_email='thofting@42berlin.com' \
            --skip-email \
            --path="/var/www/wordpress"

echo "wp user create........"
wp user create --allow-root \
            $WP_USER thomas.hoefting@gmx.de \
			--user_pass=$(<"/run/secrets/wp_user_pw") \
            --path="/var/www/wordpress"

directory="/run/php"

if [ ! -d "$directory" ]; then
    mkdir -p $directory
    echo "Directory $directory created successfully."
else
    echo "Directory $directory already exists."
fi

echo "launch php..."
exec /usr/sbin/php-fpm7.4 -F