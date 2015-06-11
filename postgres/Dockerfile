FROM debian:8
MAINTAINER Doug Stanley <doug@douglasstanley.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-mark hold initscripts udev plymouth upstart;\
    apt-get -y -q update;\
    apt-get -y -q dist-upgrade;\
    apt-get install -y -q --no-install-recommends postgresql postgresql-common postgresql-client postgresql-contrib ssl-cert ;\
    echo 'host  all             all             172.16.0.0/12           md5'>>/etc/postgresql/9.4/main/pg_hba.conf ;\
    sed -i -e "s/^#listen_addresses = 'localhost'\(.*\)/listen_addresses = '*'\1/g" /etc/postgresql/9.4/main/postgresql.conf ;\
    apt-get clean;\
    apt-get autoclean

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

VOLUME [ "/var/lib/postgresql", "/var/log/postgresql" ]

EXPOSE 5432
WORKDIR /var/lib/postgresql
USER postgres
CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D","/var/lib/postgresql/9.4/main","-c","config_file=/etc/postgresql/9.4/main/postgresql.conf"]
