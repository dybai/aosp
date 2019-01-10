FROM ubuntu:18.04

MAINTAINER bdy1234567@126.com

# docker build -t aosp:2.0 dockerfile
# docker run -it -v /home/dybai/docker/android:/home/dybai/android aosp:2.0 /bin/bash

# Set default timezone, Quietly install tzdata.
ENV DEBIAN_FRONTEND noninteractive

# Install dependent packages.
RUN apt update
RUN apt install -y apt-utils sudo vim curl net-tools iputils-ping ssh
RUN apt install -y flex lzop u-boot-tools libdb1-compat tzdata git python make lib32z1 bison g++-multilib libswitch-perl gperf libxml2-utils zip unzip bc lzop u-boot-tools

# Modify timezone.
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# Make timezone settings effective.
RUN dpkg-reconfigure -f noninteractive tzdata

# Add user, Maintain consistency with the host.
RUN useradd --create-home --shell /bin/bash -p linux123 dybai
RUN echo 'dybai:linux123' | chpasswd
RUN adduser dybai sudo
USER dybai
WORKDIR /home/dybai

# VOLUME ["/home/dybai/docker/android"]

CMD /bin/bash
