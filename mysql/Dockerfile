FROM mysql/mysql-server:5.6.29
LABEL maintainer "Yuki Tominaga<yuki_tominaga@cbase.co.jp>"

RUN sed -ie '$ a character-set-server=utf8' /etc/my.cnf && \
    sed -ie '$ a [client]' /etc/my.cnf && \
    sed -ie '$ a default-character-set=utf8' /etc/my.cnf
