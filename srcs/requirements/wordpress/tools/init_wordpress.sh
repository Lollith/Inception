#!/bin/bash

# // condition si wp-config.php nexiste pas alors lance la commade wp config create
sleep 10

wp config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 \
					--path='/var/www/wordpress'

# run php-fpm:
# exec php-fpm7.3 -F