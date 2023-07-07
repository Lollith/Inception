
FROM 	alpine:3.17.1

#general
#1 couche
RUN		apk update && apk upgrade && apk add --no-cache \
		wget \ 
		mariadb-client \
		php81 php81-fpm \
		php81-mysqli \
		php81-common php81-phar php81-mbstring 
RUN		apk add php81-cli php81-iconv 
		#needed for wp-cli

#DEBUG_listen
# RUN     apt-get install -y net-tools

#CLI : modif du file wp-config
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar
# RUN		mv -f wp-cli.phar /usr/local/bin/wp
RUN		mv -f wp-cli.phar /usr/local/bin/wp-cli.phar

#php
# RUN 	rm -f /etc/php81/php-fpm.d/www.conf
COPY	conf/www.conf /etc/php81/php-fpm.d/www.conf

#wordpress
# RUN 	wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www
# RUN 	cd /var/www && tar -xzf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz
# RUN		chmod +x /var/www
RUN  mkdir -p /var/www/wordpress
RUN  adduser -u 82 -D -S -G www-data www-data
RUN		chmod +x -R /var/www/wordpress
# RUN 	mkdir -p /var/www/html  && \ 
# RUN 	chmod 777 -R /var/www/html
# RUN		chown -R www-data:www-data /var/www/html
RUN		chown -R www-data:www-data /var/www/wordpress
# RUN		chown -R root:root /var/www/wordpress


					
EXPOSE 9000

COPY  	tools/init_wordpress.sh init_wordpress.sh
RUN 	chmod 755 init_wordpress.sh  
# CMD 	["/init_wordpress.sh"]
ENTRYPOINT 	["sh","init_wordpress.sh"]
