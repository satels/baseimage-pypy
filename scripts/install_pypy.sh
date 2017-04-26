#!/bin/bash

PYPY_VERSION=5.7.1

set -e

umask 0022
cd /tmp/
curl --silent -L -O "https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-$PYPY_VERSION-linux_x86_64-portable.tar.bz2"
tar -jxvf /tmp/pypy-$PYPY_VERSION-linux_x86_64-portable.tar.bz2 -C /usr/local
ln -s /usr/local/pypy-$PYPY_VERSION-linux_x86_64-portable/bin/libpypy-c.so /usr/lib/x86_64-linux-gnu/
ldconfig
ln -s /usr/local/pypy-$PYPY_VERSION-linux_x86_64-portable/bin/* /usr/local/bin/
cp -R /usr/local/pypy-$PYPY_VERSION-linux_x86_64-portable/virtualenv_support/ /usr/local/
sed -i "s/env\ python/env pypy/g" /usr/local/pypy-$PYPY_VERSION-linux_x86_64-portable/bin/virtualenv-pypy
rm /tmp/pypy-$PYPY_VERSION-linux_x86_64-portable.tar.bz2
