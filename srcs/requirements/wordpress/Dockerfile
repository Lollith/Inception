
FROM 	alpine:3.17.1

#general
#1 couche
RUN		apk update && apk upgrade && \
		apk add wget && \ 
		apk add php81 php81-fpm php81-mysqli &&\
		#needed for wp-cli
		apk add php81-cli php81-phar php81-iconv &&\
		apk add mariadb-client

#DEBUG_listen
# RUN     apt-get install -y net-tools

#wordpress
RUN 	wget https://fr.wordpress.org/wordpress-6.2-fr_FR.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.2-fr_FR.tar.gz && rm wordpress-6.2-fr_FR.tar.gz
RUN		chmod +x /var/www
RUN		chown -R root:root /var/www/wordpress

#CLI : modif du file wp-config
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar
# RUN		mv wp-cli.phar /usr/local/bin/wp
RUN		mv wp-cli.phar /usr/local/bin/wp
					
#php
COPY	conf/www.conf /etc/php81/php-fpm.d/www.conf


COPY  	tools/init_wordpress.sh init_wordpress.sh
RUN 	chmod 755 init_wordpress.sh  
# CMD 	["/init_wordpress.sh"]
ENTRYPOINT 	["sh","init_wordpress.sh"]
