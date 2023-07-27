
FROM 	alpine:3.17.1

#1 couche
RUN		apk update && apk upgrade && apk add --no-cache \
		wget \ 
		mariadb-client \
		php81 php81-fpm \
		php81-mysqli \
		php81-common php81-phar php81-mbstring 

#CLI : modif du file wp-config
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \	
		chmod +x wp-cli.phar && \
		mv -f wp-cli.phar /usr/local/bin/wp-cli.phar

#php
COPY	conf/www.conf /etc/php81/php-fpm.d/www.conf

RUN  	mkdir -p /var/www/wordpress && \
		chmod +x -R /var/www/wordpress && \
		adduser -u 82 -D -S -G www-data www-data && \
		chown -R www-data:www-data /var/www/wordpress

COPY  	tools/init_wordpress.sh init_wordpress.sh
RUN 	chmod 755 init_wordpress.sh  

ENTRYPOINT 	["sh","init_wordpress.sh"]

#DEBUG_listen
# RUN     apt-get install -y net-tools
# EXPOSE 9000