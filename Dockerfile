FROM kalilinux/kali-rolling

LABEL maintainer="realmadsci"

RUN apt-get -y update && apt-get -y upgrade && \
   DEBIAN_FRONTEND=noninteractive apt-get install -y \
   bash-completion \
   wget python3 \
   gdb && \
   apt-get autoremove -y && \
   apt-get clean

# Add gef (this also requires wget and python3 packages to be installed
RUN wget -O ~/.gdbinit-gef.py -q https://github.com/hugsy/gef/raw/master/gef.py
RUN echo source ~/.gdbinit-gef.py >> ~/.gdbinit

RUN printf "alias ll='ls $LS_OPTIONS -l'\nalias l='ls $LS_OPTIONS -lA'\n\n# enable bash completion in interactive shells\nif [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n    . /etc/bash_completion\nfi\nexport LC_ALL=C.UTF-8\n" > /root/.bashrc
RUN mkdir /data

WORKDIR /host
CMD "/bin/bash"
