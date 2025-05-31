FROM debian:sid

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    devscripts \
    quilt \
    autopkgtest \
    blhc \
    dh-make \
    dput-ng \
    how-can-i-help \
    git-buildpackage \
    renameutils \
    spell \
    splitpatch \
    tree \
    nano \
    bash-completion && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^#pristine-tar/pristine-tar/" /etc/git-buildpackage/gbp.conf && \
    sed -i "s/^#debian-branch = master/debian-branch = debian\/master/" /etc/git-buildpackage/gbp.conf && \
    echo "deb http://debian.org/debian sid main\ndeb-src http://debian.org/debian sid main" > /etc/apt/sources.list

RUN mkdir -p /root/PKGS
WORKDIR /root/PKGS

CMD ["/bin/bash"]
