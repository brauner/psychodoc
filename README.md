based on debian stable image created by

    cd /tmp \
    && mkdir stable \
    && debootstrap --arch=amd64 --variant=minbase --no-check-gpg --include=apt-utils,vim-tiny stable ./stable \
    && cd /tmp/stable \
    && printf '\ndeb http://ftp.de.debian.org/debian stable main contrib non-free' >> etc/apt/sources.list \
    && printf '\ndeb-src http://ftp.de.debian.org/debian stable main contrib non-free' >> etc/apt/sources.list \
    && printf '\n\ndeb http://ftp.debian.org/debian/ wheezy-updates main contrib non-free' >> etc/apt/sources.list \
    && printf '\ndeb-src http://ftp.debian.org/debian/ wheezy-updates main contrib non-free' >> etc/apt/sources.list \
    && printf '\n\ndeb http://security.debian.org/ wheezy/updates main contrib non-free' >> etc/apt/sources.list \
    && printf '\ndeb-src http://security.debian.org/ wheezy/updates main contrib non-free\n' >> etc/apt/sources.list \
    && rm -rf /tmp/stable/var/cache/apt/archives/* \
    && rm -rf /tmp/stable/var/lib/apt/lists/* \
    && tar -cf ../stable.tar . \
    && sudo -u ${USER} docker import - brauner/debian:stable < /tmp/stable.tar

Pull image from `Dockerhub`:

    docker pull brauner/psychopy
