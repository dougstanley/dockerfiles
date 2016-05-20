#!/bin/sh
set -e
if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi

if [ "$1" = 'mysqld' ]; then
    test -e /run/mysqld || install -m 755 -o mysql -g root -d /run/mysqld

    if [ ! -d /var/lib/mysql/mysql ]; then
        chown -R mysql:mysql /var/lib/mysql
        chmod 0770 /var/lib/mysql
        su -s /bin/sh -c 'mysql_install_db --force --user=mysql >/dev/null' mysql

        set -- su -s /bin/sh -c "$@" mysql
    fi

fi

exec "$@"
