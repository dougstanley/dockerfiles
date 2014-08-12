#!/bin/bash
set -e

mkdir -p /var/run/postgresql || exit 101
chown -R postgres:postgres /var/run/postgresql || exit 101

/etc/init.d/postgresql start || exit 101
sleep 1
while [ ! -S /var/run/postgresql/.s.PGSQL.5432 ]; do echo waiting for postgres to start;sleep 5;done

su -c "psql --command \"CREATE USER pgdev WITH SUPERUSER PASSWORD 'pgdev';\"" - postgres
/etc/init.d/postgresql stop || exit 101

exit 0
