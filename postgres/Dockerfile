FROM debian:8
MAINTAINER Doug Stanley <doug@douglasstanley.com>

ENV DEBIAN_FRONTEND noninteractive

ADD run.sh /run.sh

RUN apt-mark hold initscripts udev plymouth upstart ;\
    apt-get -y -q update ;\
    apt-get -y -q dist-upgrade ;\
    apt-get install -y -q --no-install-recommends postgresql postgresql-common postgresql-client postgresql-contrib ssl-cert ;\
    echo 'host  all             all             172.16.0.0/12           md5'>>/etc/postgresql/9.4/main/pg_hba.conf ;\
    sed -i -e "s/^#listen_addresses = 'localhost'\(.*\)/listen_addresses = '*'\1/g" /etc/postgresql/9.4/main/postgresql.conf ;\
    rm -rf /tmp/* ;\
    rm -f /var/lib/apt/lists/* ;\
    apt-get clean ;\
    apt-get autoclean ;\
    locale-gen en_US en_US.UTF-8 ;\
    dpkg-reconfigure locales ;\
    chmod a+rx /run.sh


VOLUME [ "/var/lib/postgresql", "/var/log/postgresql" ]

EXPOSE 5432
WORKDIR /var/lib/postgresql
USER root
CMD ["/run.sh"]
