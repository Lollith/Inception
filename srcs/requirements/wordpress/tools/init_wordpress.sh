#!/bin/bash

# // condition si wp-config.php nexiste pas alors lance la commade wp config create

wp config create --allow-root 	--dbname="ade" \
											--dbuser="ade" \
											--path='/var/www/wordpress'
											# --dbpass=$SQL_PASSWORD \