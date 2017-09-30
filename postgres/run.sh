#!/bin/sh
set -e
if [ "${1:0:1}" = '-' ]; then
	set -- postgres "$@"
fi
. /etc/conf.d/postgresql

: ${user:=${PGUSER:-"postgres"}}
: ${group:=${PGGROUP:-"postgres"}}
: ${data_dir:=${PGDATA:-"/var/lib/postgresql/9.6/data"}}
: ${conf_dir:=$data_dir}
: ${env_vars:=${PG_EXTRA_ENV:-}}
: ${initdb_opts:=${PG_INITDB_OPTS:-}}
: ${pg_opts:=${PGOPTS:-}}
: ${port:=${PGPORT:-5432}}

RUNDIR="/run/postgresql"

if [ ! -d ${RUNDIR} ]; then
    mkdir -p ${RUNDIR} && \
    chmod 1775 ${RUNDIR} && \
    chown -R ${user}:${group} ${RUNDIR}

fi
if [ ! -d ${data_dir} ]; then
  mkdir -p ${data_dir}
  chown -R postgres:postgres /var/lib/postgresql/
  chmod -R 0700 /var/lib/postgresql
  su -c "${env_vars} /usr/bin/initdb $initdb_opts -D ${data_dir} --auth-host=md5 --auth-local=peer" - ${user} 
  sed  \
    -e "s/^#\(listen_addresses.*=.*\)\(localhost\)\(.*\)$/\1*\3/" \
    -e 's/^#\(port\s*=\s*5432.*\)$/\1/' \
    -i ${data_dir}"/postgresql.conf"

  echo -e 'host\tall\t\tall\t\t0.0.0.0/0\t\tmd5' >> ${data_dir}"/pg_hba.conf"
fi

if [ "$1" = 'postgres' ]; then
    set -- su -c 'postgres -D '"${data_dir} -o --data-directory=${data_dir} ${pg_opts}" - ${user}
fi

exec "$@"
