FROM dstanley/buildhost:jessie
MAINTAINER Doug Stanley <doug@technologixllc.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y -q update; \
    apt-get -y -q install --no-install-recommends \
		python3 \
        python3-all \
		python-all-dev \
		python3-dev \
        python3-setuptools \
        python3-pip \
        python3-pkg-resources \
        python3-virtualenv \
        libpython3-all-dev \
        libpython3-dev \
        libpython3-stdlib \
        python3-lxml \
        python3-openssl \
        xml-core ;\
    apt-get clean; \
    apt-get autoclean; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*
