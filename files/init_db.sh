#/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
  echo 'new database creation'
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  echo 'new database created'
fi

