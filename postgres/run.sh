#!/bin/sh
set -e
if [ "${1:0:1}" = '-' ]; then
	set -- postgres "$@"
fi
. /etc/conf.d/postgresql

if [ ! -d ${PGDATA} ]; then
  mkdir -p ${PGDATA}
  chown -R postgres:postgres /var/lib/postgresql/
  chmod -R 0700 /var/lib/postgresql
  su -c "/usr/bin/initdb -D ${PGDATA} --auth-host=md5 --auth-local=peer" - postgres
  sed  \
    -e "s/^#\(listen_addresses.*=.*\)\(localhost\)\(.*\)$/\1*\3/" \
    -e 's/^#\(port\s*=\s*5432.*\)$/\1/' \
    -i ${PGDATA}"/postgresql.conf"

  echo -e 'host\tall\t\tall\t\t0.0.0.0/0\t\tmd5' >> ${PGDATA}"/pg_hba.conf"
fi

if [ "$1" = 'postgres' ]; then
    set -- su -c 'postgres -D '"${PGDATA}" - postgres
fi

exec "$@"
