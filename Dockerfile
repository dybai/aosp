FROM ubuntu:16.04

MAINTAINER bdy1234567@126.com

# docker build -t dybai/aosp:2.0 . --build-arg user=dybai --build-arg password=linux123 --build-arg uid=1000 --build-arg gid=1000 --build-arg home=/home/external_1/dybai
# docker run -it -v /home/dybai/docker/android:/home/dybai/android dybai/aosp:2.0 /bin/bash

ARG user=dybai
ARG password=linux123
ARG uid=1000
ARG gid=1000
ARG home="/home/dybai"

# Set default timezone, Quietly install tzdata.
ENV DEBIAN_FRONTEND noninteractive

# Install dependent packages.
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y sudo vim curl net-tools iputils-ping ssh bash-completion
RUN apt-get install -y openjdk-8-jdk flex lzop u-boot-tools libdb1-compat tzdata git python make lib32z1 bison g++-multilib libswitch-perl gperf libxml2-utils zip xz-utils bc lzop u-boot-tools
RUN apt-get install -y kmod mkisofs rsync

# Modify timezone.
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# Make timezone settings effective.
RUN dpkg-reconfigure -f noninteractive tzdata

# Add user, Maintain consistency with the host.
RUN mkdir -p ${home}
RUN useradd --home ${home} --shell /bin/bash -p ${password} ${user}
RUN echo "${user}:${password}" | chpasswd

# Modify UID and GID to be consistent with the host.
RUN usermod -u ${uid} ${user}
RUN groupmod -g ${gid} ${user}

RUN chown -R ${user}:${user} ${home}

RUN adduser ${user} sudo

USER ${user}
WORKDIR ${home}

CMD /bin/bash
