#!/bin/bash

if [ ! -d /var/lib/postgresql/9.4/main ]; then
  mkdir -p /var/lib/postgresql/9.4/main
  chown -R postgres:postgres /var/lib/postgresql/
  chmod -R 0700 /var/lib/postgresql
  /usr/lib/postgresql/9.4/bin/initdb -D /var/lib/postgresql/9.4/main
fi

if [ ! -d /var/run/postgresql/9.4-main.pg_stat_tmp ]; then
    mkdir -p /var/run/postgresql/9.4-main.pg_stat_tmp
    chown postgres:postgres /var/run/postgresql/9.4-main.pg_stat_tmp
fi

su -c "/usr/lib/postgresql/9.4/bin/postgres -D /var/lib/postgresql/9.4/main \
      -c config_file=/etc/postgresql/9.4/main/postgresql.conf" \
      - postgres
