#! /bin/bash

echo "Start mariadb server"
service mariadb start

sleep 1
echo "MariaDB is ready! Setting up users and databases..."

echo "create wordpress database"
mariadb -u root -p$(<"/run/secrets/mysql_root_pw") -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

sleep 1
echo "create user"
mariadb -u root -p$(<"/run/secrets/mysql_root_pw") -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '$(<"/run/secrets/mysql_pw")' ;"

sleep 1
echo "grant privileges"
mariadb -u root -p$(<"/run/secrets/mysql_root_pw") -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '$(<"/run/secrets/mysql_pw")';"

sleep 1
echo "add password for root"
mariadb -u root -p$(<"/run/secrets/mysql_root_pw") -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(<"/run/secrets/mysql_root_pw")';"

sleep 1
echo "reset privileges"
mariadb -u root -p$(<"/run/secrets/mysql_root_pw") -e "FLUSH PRIVILEGES;"


sleep 1
echo "restart mysql"
mysqladmin -u root -p$(<"/run/secrets/mysql_root_pw") shutdown

sleep 1
echo "exec mariadb server as foreground process"
mariadbd-safe