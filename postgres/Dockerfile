FROM ubuntu:14.04
MAINTAINER Doug Stanley <doug@douglasstanley.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-mark hold initscripts udev plymouth mountall upstart;\
    apt-get -y -q update;\
    apt-get -y -q dist-upgrade;\
    apt-get install -y -q postgresql postgresql-client postgresql-contrib;\
    apt-get clean;\
    apt-get autoclean

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales

# mysql config
ADD ./config /config
RUN cp /config/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf;\
    cp /config/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf;\
    /bin/bash /config/setup.sh;\
    rm -rf /config

VOLUME [ "/var/lib/postgresql", "/var/log/postgresql" ]

EXPOSE 5432
WORKDIR /var/lib/postgresql
USER postgres
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D","/var/lib/postgresql/9.3/main","-c","config_file=/etc/postgresql/9.3/main/postgresql.conf"]
