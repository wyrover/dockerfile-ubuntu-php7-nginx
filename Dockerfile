FROM ubuntu:latest

MAINTAINER Lee Yen <leeyenwork@gmail.com>

ENV TERM xterm

RUN apt-get -y update
RUN apt-get -y install nginx \
    php-gettext php-pear php-imagick \
    php7.0-curl php7.0-dev libgpgme11-dev libpcre3-dev \
    php7.0-fpm php7.0-gd php7.0-imap \
    php7.0-mcrypt php7.0-mysqlnd php7.0-sybase \
    php7.0-intl git nano wget supervisor curl

RUN curl -sL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# html to pdf
RUN apt-get install -y libssl-dev libxrender-dev gdebi
RUN cd /tmp && \
   wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
   gdebi --n wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
RUN apt-get -y install xvfb fonts-wqy-microhei

RUN apt-get remove -y vim-common
RUN apt-get install -y vim

RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    echo 'LANG="zh_TW.UTF-8"' > /etc/default/locale && \
    echo 'LANG="zh_HK.UTF-8"' > /etc/default/locale && \
    echo 'LANG="zh_CN.UTF-8"' > /etc/default/locale && \
    echo 'LANG="th_TH.UTF-8"' > /etc/default/locale && \
    echo 'LANG="id_ID.UTF-8"' > /etc/default/locale && \
    echo 'LANG="ko_KR.UTF-8"' > /etc/default/locale && \
    echo 'LANG="ja_JP.UTF-8"' > /etc/default/locale && \
    locale-gen en_US.UTF-8 && \
    locale-gen zh_TW.UTF-8 && \
    locale-gen zh_CN.UTF-8 && \
    locale-gen zh_HK.UTF-8 && \
    locale-gen th_TH.UTF-8 && \
    locale-gen id_ID.UTF-8 && \
    locale-gen ko_KR.UTF-8 && \
    locale-gen ja_JP.UTF-8

COPY ./configs/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./configs/supervisord/conf.d/* /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord"]

EXPOSE 80