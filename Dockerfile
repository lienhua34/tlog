FROM ubuntu:18.04
RUN apt-get update && apt-get install -y pkg-config libjson-c-dev libsystemd-dev libcurl-ocaml-dev autoconf automake libtool
RUN apt-get install -y openssh-server rsyslog rsyslog-elasticsearch

WORKDIR /tlog
COPY . /tlog/

COPY ./myconfig/ssh_config /etc/ssh/ssh_config
COPY ./myconfig/rsyslog.conf /etc/rsyslog.conf

RUN autoreconf -i -f && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var && make && make install
RUN rm -rf *

CMD ["/bin/bash", "-c", "/etc/init.d/ssh start && /etc/init.d/rsyslog start"]