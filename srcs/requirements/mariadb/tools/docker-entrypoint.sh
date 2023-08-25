#!/bin/bash
set -e

# Start MariaDB server
mysqld --user=root &

# Wait for MariaDB to start
until mysqladmin ping -hlocalhost -uroot -p${MYSQL_ROOT_PASSWORD} > /dev/null 2>&1; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done

# Execute initialization commands
mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE DATABASE ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the temporary MariaDB instance
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

# Start the actual MariaDB instance
exec mysqld --user=root
