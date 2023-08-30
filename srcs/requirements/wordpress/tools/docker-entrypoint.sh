#!/bin/bash
set -e

# Set privileges
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Make directory for php7.4-fpm.pid
mkdir -p /run/php

# Install wp-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Wordpress Installation
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOSTNAME --allow-root
    wp core install --url=https://$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --allow-root
fi

# Execute php-fpm
exec php-fpm7.4 -F

