FROM php:7.0.16-apache
LABEL maintainer "Yuki Tominaga<yuki_tominaga@cbase.co.jp>"

RUN apt-get update && \
    apt-get install -y vim \
    wget \
    bzip2 \
    libjpeg-dev \
    libpng12-dev \
    libncurses5-dev \
    libaio-dev \
    libfreetype6-dev \
    locales && \
    locale-gen ja_JP.UTF-8 && \
    localedef -f UTF-8 -i ja_JP ja_JP

ENV LANG=ja_JP.UTF-8 \
    LC_ALL=ja_JP.UTF-8 \
    TERM=xterm-256color \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_DIR=/var/run/apache2 \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data

RUN docker-php-source extract && \
    pecl install redis && \
    pecl install xdebug && \
    docker-php-ext-enable redis xdebug && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install opcache && \
    docker-php-ext-configure gd \
        --with-jpeg-dir=/usr/local \
        --with-freetype-dir=/usr/local \
        --with-png-dir=/usr/local \
        --enable-gd-native-ttf \
        --enable-gd-jis-conv && \
    docker-php-ext-install gd && \
    docker-php-ext-install zip && \
    docker-php-source delete
COPY php.ini /usr/local/etc/php
ADD php.tar.gz /usr/local/lib

WORKDIR /usr/local/src
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64\.tar.bz2 && \
    tar xf phantomjs-2.1.1-linux-x86_64.tar.bz2
COPY rasterize /usr/local/src/phantomjs-2.1.1-linux-x86_64/bin/rasterize
RUN ln -bs /usr/local/src/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
    ln -bs /usr/local/src/phantomjs-2.1.1-linux-x86_64/bin/rasterizejs /usr/local/bin/rasterizejs && \
    ln -bs /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load && \
    ln -bs /etc/apache2/mods-available/authz_groupfile.load /etc/apache2/mods-enabled/authz_groupfile.load && \
    ln -bs /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load && \
    sed -i "s/#ServerName www.example.com/ServerName local.cservice.jp:80/g" /etc/apache2/sites-enabled/000-default.conf

ENTRYPOINT ["docker-php-entrypoint"]
EXPOSE 80
CMD ["apache2-foreground"]
