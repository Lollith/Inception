#!/bin/bash

# // condition si wp-config.php nexiste pas alors lance la commade wp config create

if [ ! -f /var/www/wordpress/wp-config.php ]; then
sleep 10

wp-cli.phar config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 \
					--path='/var/www/wordpress'


else
	echo "wp_config php DONE"
fi

if [ ! -d /run/php ]; then
	mkdir -p /run/php #creer ds un path donner le dossier
fi

# run php-fpm:
exec php-fpm7.3 -F