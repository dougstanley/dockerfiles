FROM ubuntu:14.04
MAINTAINER Doug Stanley <doug@douglasstanley.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-mark hold initscripts udev plymouth mountall upstart;\
    apt-get -y -q update;\
    apt-get -y -q dist-upgrade;\
    apt-get install -y -q --no-install-recommends apt-cacher-ng;\
    apt-get clean;\
    apt-get autoclean

VOLUME ["/var/cache/apt-cacher-ng"]
EXPOSE 3142
CMD chmod 0777 /var/cache/apt-cacher-ng;\
    /etc/init.d/apt-cacher-ng start;\
    tail -f /var/log/apt-cacher-ng/apt-cacher.log
