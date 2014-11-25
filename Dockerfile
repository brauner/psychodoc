FROM brauner/debian:testing

MAINTAINER Christian Brauner christianvanbrauner[at]gmail.com

RUN export DEBIAN_FRONTEND=noninteractive \
&& printf '\npath-exclude=/usr/share/locale/*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/locale/en*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/locale/locale.alias' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-exclude=/usr/share/man/*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/man/en*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& printf '\npath-include=/usr/share/man/man[1-9]/*' >> /etc/dpkg/dpkg.cfg.d/excludes \
&& apt-get update -qq -y \
&& apt-get install -y --no-install-recommends \
   locales \
   less \
   wget \
   zip \
   unzip \
&& wget -O- http://neuro.debian.net/lists/jessie.de-m.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
&& apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 2649A5A9 \
&& apt-get update -qq -y \
&& apt-get install -y \
   flac \
   psychopy \
   python-pypsignifit \
   python-parallel \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
RUN echo 'root:test' | chpasswd \
&& useradd -u 1000 -m docker \
&& echo 'docker:test' | chpasswd \
&& usermod -s /bin/bash docker \
&& usermod -a -G 100 docker \
&& usermod -a -G sudo docker \
&& groupmod -g 91 video \
&& usermod -a -G video docker \
&& groupmod -g 92 audio \
&& usermod -a -G audio docker \
&& printf '\nen_IE.UTF-8 UTF-8\n' >> /etc/locale.gen \
&& locale-gen \
&& cd \
&& printf '# If not running interactively, don'\''t do anything\n[[ \$- != *i* ]] && return\n\nalias ls='\''ls --color=auto'\''\n\nalias grep='\''grep --color=auto'\''\n\nPS1='\''[\\u@\h \W]\\$ '\''\n\ncomplete -cf sudo\n\n# Set default editor.\nexport EDITOR=vim xterm\n\nexport OPENBLAS_NUM_THREADS=4\n\n# Enable vi editing mode.\nset -o vi\n' > /home/docker/.bashrc \
&& printf '# If not running interactively, don'\''t do anything\n[[ \$- != *i* ]] && return\n\nalias ls='\''ls --color=auto'\''\n\nalias grep='\''grep --color=auto'\''\n\nPS1='\''[\\u@\h \W]\\$ '\''\n\ncomplete -cf sudo\n\n# Set default editor.\nexport EDITOR=vim xterm\n\nexport OPENBLAS_NUM_THREADS=4\n\n# Enable vi editing mode.\nset -o vi\n' > /root/.bashrc \
&& printf 'set editing-mode vi\n\nset keymap vi-command\n' > /home/docker/.inputrc \
&& printf 'set editing-mode vi\n\nset keymap vi-command\n' > /root/.inputrc

ENV LANG en_IE.UTF-8
ENV HOME /home/docker
WORKDIR /home/docker
USER docker
