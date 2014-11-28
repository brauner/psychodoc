FROM debian:stable

MAINTAINER Christian Brauner christianvanbrauner[at]gmail.com

RUN export DEBIAN_FRONTEND=noninteractive \
&& printf '\npath-exclude=/usr/share/locale/*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/locale/en*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/locale/locale.alias' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-exclude=/usr/share/man/*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/man/en*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/man/man[1-9]/*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\ndeb http://neurodebian.g-node.org data main contrib non-free' > /etc/apt/sources.list.d/neurodebian.sources.list \
&& printf '\ndeb-src http://neurodebian.g-node.org data main contrib non-free' >> /etc/apt/sources.list.d/neurodebian.sources.list \
&& printf '\ndeb http://neurodebian.g-node.org wheezy main contrib non-free' >> /etc/apt/sources.list.d/neurodebian.sources.list \
&& printf '\ndeb-src http://neurodebian.g-node.org wheezy main contrib non-free\n' >> /etc/apt/sources.list.d/neurodebian.sources.list \
&& apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 2649A5A9 \
&& apt-get update -qq -y \
&& apt-get install -y --no-install-recommends \
# Sound
   alsa-base \
   alsa-utils \
   alsa-oss \
   bash-completion \
   ca-certificates \
   git \
   locales \
   less \
   mupdf \
   sudo \
   wget \
   zip \
   unzip \
# 3D
   libegl1-mesa \
   libgl1-mesa-dri \
   libgl1-mesa-glx \
   libopenvg1-mesa \
   libglu1-mesa-dev \
   mesa-utils \
# Sound
   alsa-base \
   alsa-utils \
   alsa-oss \
   flac \
# Psychopy deps
   python \
   python-setuptools \
   python-numpy \
   python-scipy \
   python-pyglet \
   python-wxgtk2.8 \
   python-wxtools \
   python-wxversion \
   python-imaging \
   python-matplotlib \
   python-lxml \
   python-openpyxl \
   python-pyo \
# Psychopy opt deps
   python-optcomplete \
   python-pypsignifit \
   python-parallel \
   python-serial \
   python-sphinx \
   python-tk \
&& echo 'root:test' | chpasswd \
&& useradd -u 1000 -m docker \
&& echo 'docker:test' | chpasswd \
&& usermod -s /bin/bash docker \
&& usermod -a -G 100 docker \
&& usermod -a -G sudo docker \
# set correct GID should your distro differ
# && groupmod -g 91 video \
&& usermod -a -G video docker \
# set correct GID should your distro differ
# && groupmod -g 92 audio \
&& usermod -a -G audio docker \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/docker
WORKDIR /home/docker
USER docker

RUN cd /home/docker \
&& printf '\nexport PYTHONPATH=/home/docker/psychopy:$PATH\n' >> /home/docker/.profile \
&& cd /home/docker \
&& git clone https://github.com/psychopy/psychopy.git
