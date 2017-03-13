CREATE USER 'bkpuser'@'localhost' IDENTIFIED BY 'bkpuser_pass';
GRANT RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO 'bkpuser'@'localhost';
FLUSH PRIVILEGES;
