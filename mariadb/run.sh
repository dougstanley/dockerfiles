#!/bin/bash
set -e
if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi

if [ "$1" = 'mysqld' ]; then
    test -e /var/run/mysqld || install -m 755 -o mysql -g root -d /var/run/mysqld

    if [ ! -d /var/lib/mysql/mysql ]; then
        if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
            export MYSQL_ROOT_PASSWORD="mysqlsux"
        fi
        chown -R mysql:mysql /var/lib/mysql
        chmod 0770 /var/lib/mysql
        mysql_install_db --force --user=mysql >/dev/null

        initsql=$(tempfile -p init- -s .sql)
        echo "DELETE FROM mysql.user;" >> $initsql
        echo "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> $initsql
        echo "GRANT ALL ON *.* to 'root'@'%' WITH GRANT OPTION;" >> $initsql
        echo "DROP DATABASE IF EXISTS test;" >> $initsql
        echo "FLUSH PRIVILEGES;" >> $initsql

        chown mysql $initsql

        set -- "$@" --init-file="${initsql}"
    fi

fi

exec "$@"
