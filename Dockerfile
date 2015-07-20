FROM phusion/baseimage:0.9.16
MAINTAINER Jeethu Rao <jeethu.rao@dubizzle.com>

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

RUN set -e; \
    umask 0022; \
    apt-get update; apt-get -yq install wget python; \
    wget -q https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-2.6-linux_x86_64-portable.tar.bz2 -P /tmp/; \
    tar -xjf /tmp/pypy-2.6-linux_x86_64-portable.tar.bz2 -C /usr/local; \
    ln -s /usr/local/pypy-2.6-linux_x86_64-portable/bin/libpypy-c.so /usr/lib/x86_64-linux-gnu/; \
    ldconfig; \
    ln -s /usr/local/pypy-2.6-linux_x86_64-portable/bin/* /usr/local/bin/; \
    cp -R /usr/local/pypy-2.6-linux_x86_64-portable/virtualenv_support/ /usr/local/; \
    rm /tmp/pypy-2.6-linux_x86_64-portable.tar.bz2; \
    apt-get purge -yq wget; \
    apt-get -yq autoremove; \
    apt-get autoclean

# Patch OpenSSL to enable SSLv2_method
RUN DEBIAN_FRONTEND=noninteractive set -e; \
    apt-get update; \
    apt-get -yq install build-essential devscripts zlib1g-dev; \
    apt-get -yq build-dep openssl; \
    mkdir /tmp/openssl-build; \
    cd /tmp/openssl-build; \
    apt-get source openssl; \
    cd /tmp/openssl-build; \
    sed -i.bak 's/no-ssl2//' /tmp/openssl-build/openssl-1.0.1f/debian/rules; \
    cd /tmp/openssl-build/openssl-1.0.1f; \
    dch -n 'Enable SSLv2'; \
    dpkg-source --commit; \
    debuild -uc -us; \
    cd /tmp/openssl-build; \
    dpkg -i *ssl*.deb; \
    cd /; \
    rm -rf /tmp/openssl-build; \
    apt-get autoremove -yq $(apt-cache showsrc openssl | sed -e '/Build-Depends/!d;s/Build-Depends: \|,\|([^)]*),*\|\[[^]]*\]//g'); \
    apt-get purge -yq build-essential devscripts zlib1g-dev; \
    apt-get -yq autoremove; \
    apt-get autoclean
