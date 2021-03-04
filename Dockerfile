FROM kalilinux/kali-rolling

LABEL maintainer="realmadsci"

RUN apt-get -y update && apt-get -y upgrade && \
   DEBIAN_FRONTEND=noninteractive apt-get install -y \
   bash-completion && \
   gdb && \
   apt-get autoremove -y && \
   apt-get clean

RUN printf "alias ll='ls $LS_OPTIONS -l'\nalias l='ls $LS_OPTIONS -lA'\n\n# enable bash completion in interactive shells\nif [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n    . /etc/bash_completion\nfi\n" > /root/.bashrc
RUN mkdir /data

WORKDIR /host
CMD "/bin/bash"
