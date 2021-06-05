# Qualquer coisa, ALTERAR A OPÇÃO --NETWORK para a que estiver de acordo com o docker compose
# Usar o `docker network ls` para listas as redes.

mysql -uproxysql_user -pproxysql1234 -h127.0.0.1 -P6033 -e"CREATE DATABASE sbtest"

docker run \
--rm=true \
--name=sb-prepare \
--network lab-mysql-1_lab-network \
severalnines/sysbench \
sysbench \
--db-driver=mysql \
--oltp-table-size=1000 \
--oltp-tables-count=24 \
--threads=1 \
--mysql-host=proxysql \
--mysql-port=6033 \
--mysql-user=proxysql_user \
--mysql-password=proxysql1234 \
/usr/share/sysbench/tests/include/oltp_legacy/parallel_prepare.lua \
run

docker run \
--name=sb-run \
--network lab-mysql-1_lab-network \
severalnines/sysbench \
sysbench \
--db-driver=mysql \
--report-interval=2 \
--mysql-table-engine=innodb \
--oltp-table-size=100000 \
--oltp-tables-count=24 \
--threads=64 \
--time=99999 \
--mysql-host=proxysql \
--mysql-port=6033 \
--mysql-user=proxysql_user \
--mysql-password=proxysql1234 \
/usr/share/sysbench/tests/include/oltp_legacy/oltp.lua \
run