
CREATE ROLE `replication`@`%`;
GRANT REPLICATION SLAVE ON *.* TO `replication`@`%`;

-- GRANT ALL PRIVILEGES ON *.* TO `supa`@`127.0.0.1` WITH GRANT OPTION;

-- CREATE USER `proxysql_user`@`127.0.0.1` IDENTIFIED BY 'proxysql1234';
-- GRANT `supa`@`127.0.0.1` TO `proxysql`@`%`, `proxysql`@`127.0.0.1`; 



CREATE USER `repl_user`@`%` IDENTIFIED WITH mysql_native_password BY 'repl_user1234';
GRANT `replication`@`%` TO `repl_user`@`%`; 

FLUSH PRIVILEGES;