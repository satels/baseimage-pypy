FROM phusion/baseimage:0.9.17
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
