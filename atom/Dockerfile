FROM debian:jessie
MAINTAINER Doug Stanley <doug@douglasstanley.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y -q update ;\
    apt-get install -y -q --no-install-recommends apt-transport-https curl \
    ca-certificates python-flake8 python3-flake8 ; \
    curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | \
    apt-key add - ; \
    echo 'deb https://deb.nodesource.com/node_0.10 jessie main' > \
    /etc/apt/sources.list.d/nodesource.list ;\
    apt-get -y -q update ;\
    apt-get -y -q dist-upgrade ;\
    apt-get install -y -q nodejs git ; \
    curl -sSL -o '/root/atom-amd64.deb' \
    'https://github.com/atom/atom/releases/download/v1.5.3/atom-amd64.deb' ;\
    dpkg -i /root/atom-amd64.deb ;\
    apt-get -y -q -f install ;\
    apt-get purge -y -q ntfs-3g sane-utils gdisk ;\
    apt-get -y -q autoremove ;\
    apt-get clean ; apt-get autoclean ;\
    rm -f /root/atom-amd64.deb ;\
    rm -rf /var/lib/apt/lists/* ;\
    adduser --disabled-password --gecos 'Atom' --uid 1000 atom

USER atom

# Autorun atom
CMD /usr/bin/atom --foreground --log-file /tmp/atom.log && tail -f /tmp/atom.log
