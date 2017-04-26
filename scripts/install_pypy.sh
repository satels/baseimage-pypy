#!/bin/bash

set -e
umask 0022
cd /tmp/
curl --silent -L -O "https://bitbucket.org/squeaky/portable-pypy/downloads/pypy-4.0.1-linux_x86_64-portable.tar.bz2"
tar -xjf /tmp/pypy-4.0.1-linux_x86_64-portable.tar.bz2 -C /usr/local
ln -s /usr/local/pypy-4.0.1-linux_x86_64-portable/bin/libpypy-c.so /usr/lib/x86_64-linux-gnu/
ldconfig
ln -s /usr/local/pypy-4.0.1-linux_x86_64-portable/bin/* /usr/local/bin/
cp -R /usr/local/pypy-4.0.1-linux_x86_64-portable/virtualenv_support/ /usr/local/
sed -i "s/env\ python/env pypy/g" /usr/local/pypy-4.0.1-linux_x86_64-portable/bin/virtualenv-pypy
rm /tmp/pypy-4.0.1-linux_x86_64-portable.tar.bz2
