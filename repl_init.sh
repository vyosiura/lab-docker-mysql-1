#!/bin/bash

MYSQL_USER="root"
MYSQL_PASSWORD="root"
PRIMARY="mysql_1"
SECONDARY="localhost"

until mysql -h${PRIMARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"select @@version"
do
    echo "..."
    sleep 2
done 

until mysql -h${SECONDARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"CHANGE MASTER TO MASTER_PORT = 3306, MASTER_USER = 'repl_user', MASTER_PASSWORD = 'repl_user1234', MASTER_HOST = 'mysql_1';"
do
    echo "Waiting for read replica to be ready..."
    sleep 1
done



mysql -h${PRIMARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"CREATE ROLE supa"
mysql -h${PRIMARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"GRANT ALL PRIVILEGES ON *.* TO 'supa' WITH GRANT OPTION"
mysql -h${PRIMARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"CREATE USER proxysql_user@'%' IDENTIFIED WITH mysql_native_password BY 'proxysql1234'"
mysql -h${PRIMARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"GRANT supa TO 'proxysql_user'@'%'"
mysql -h${PRIMARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"FLUSH PRIVILEGES"
mysql -h${SECONDARY} -u${MYSQL_USER} -p${MYSQL_PASSWORD} -e"SET GLOBAL super_read_only=1"



echo "Replication configuration succeeded"