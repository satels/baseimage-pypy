FROM phusion/baseimage:0.9.17
MAINTAINER Jeethu Rao <jeethu.rao@dubizzle.com>

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive

COPY scripts/ /root/scripts/

RUN /bin/bash /root/scripts/install_pypy.sh
