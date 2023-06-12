FROM 	debian:buster

#general
RUN		apt-get update && apt upgrade -y && \
                apt-get install openssl -y && \
                apt-get install nginx -y
#	        apt install vim -y
#		apt install curl -y 
#DEBUG_listen
# RUN           apt-get install -y net-tools

#securite		
RUN 	        mkdir -p /etc/nginx/ssl
RUN 	        openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
                -keyout /etc/nginx/ssl/inception.key \
                -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=agouet.42.fr/UID=agouet"

#NGINX
RUN 	mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN 	chmod 755 /var/www/html
RUN 	chown -R www-data:www-data /var/www/html

#1er plan pour que le conteneur ne s'arrete pas
CMD ["nginx", "-g", "daemon off;" ]



