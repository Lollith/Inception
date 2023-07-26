#!/bin/sh

set -x
#check si wp-config.php pas deja cree
if [ ! -f /var/www/wordpress/wp-config.php ]; then
	# sleep 20

	/usr/local/bin/wp-cli.phar  core download --allow-root --path=/var/www/wordpress
							
	# sleep 40
	./wait

	#configurtion  de wordpress a son lancement
	/usr/local/bin/wp-cli.phar config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path=/var/www/wordpress

	# sleep 40
	#1er utilisateur 
	# /usr/local/bin/wp-cli.phar core install --allow-root \
	# 				--url=$DOMAIN_NAME \
	# 				--title=$WP_TITLE \
	# 				--admin_user=$WP_ADMIN \
	# 				--admin_password=$WP_ADMIN_PASSWORD \
	# 				--admin_email=$WP_ADMIN_EMAIL \
	# 				--path=/var/www/wordpress

	#2eme utilisateur
	# wp user create --allow-root \
	# 				"$WP_USER" \
	# 				"$WP_USER_EMAIL" \
	# 				--role=author \
	# 				--user_pass=$WP_USER_PASSWORD \
	# 				--path='/var/www/wordpress'

else
	echo "wp_config php DONE"
fi

# Create the folder to enable php start
# if [ ! -d /run/php ]; then
	# mkdir -p /run/php
# fi
set +x
#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
exec php-fpm81 -F -R