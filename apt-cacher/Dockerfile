FROM ubuntu:16.04
MAINTAINER Doug Stanley <doug@douglasstanley.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y -q update && \
    apt-get install -y -q --no-install-recommends apt-cacher-ng ;\
    sed -i -e \
    '/^# Default:$/{N;/\n# PassThroug.*$/{s//&\nPassThroughPattern: \^\.\*:443\$/;P;D}}' \
    /etc/apt-cacher-ng/acng.conf ;\
    apt-get clean && apt-get autoclean

VOLUME ["/var/cache/apt-cacher-ng"]
EXPOSE 3142
CMD chmod 0777 /var/cache/apt-cacher-ng;\
    /etc/init.d/apt-cacher-ng start;\
    tail -f /var/log/apt-cacher-ng/apt-cacher.log
