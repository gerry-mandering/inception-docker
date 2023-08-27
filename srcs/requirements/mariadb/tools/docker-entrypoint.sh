#!/bin/bash
set -e

# Set privileges
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
chmod 777 /var/run/mysqld

# Start MariaDB server
mysqld --user=root &

# Wait for MariaDB to start
until mysqladmin ping -hlocalhost -uroot > /dev/null 2>&1; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Execute initialization commands
mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the temporary MariaDB instance
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# Start the actual MariaDB instance
exec mysqld --user=mysql
