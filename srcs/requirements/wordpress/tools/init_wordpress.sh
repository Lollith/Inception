#!/bin/bash

#check si wp-config.php pas deja cree
if [ ! -f /var/www/wordpress/wp-config.php ]; then
	sleep 10

	wp-cli.phar core download --allow-root \ 
					--path='/var/www/wordpress'
							

	#configurtion  de wordpress a son lancement
	wp-cli.phar config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 \
					--path='/var/www/wordpress'

	sleep 10
	wp-cli.phar theme install atra --activate
	sleep 10

	#1er utilisateur 
	wp-cli.phar core install --allow-root \
					--url=$DOMAIN_NAME \
					--title=$WP_TITLE \
					--admin_user=$WP_ADMIN \
					--admin_password=$WP_ADMIN_PASSWORD \
					--admin_email=$WP_ADMIN_EMAIL \
					--path='/var/www/wordpress'
					# --skip-email \

	#2eme utilisateur
	wp-cli.phar user create --allow-root \
					"$WP_USER" \
					"$WP_USER_EMAIL" \
					--role=author \
					--user_pass=$WP_USER_PASSWORD \
					--path='/var/www/wordpress'

else
	echo "wp_config php DONE"
fi

# Create the folder to enable php start
if [ ! -d /run/php ]; then
	mkdir -p /run/php
fi

#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
exec php-fpm7.3 -F -R