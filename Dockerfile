FROM ubuntu:14.04
MAINTAINER Jason Nall <jason@dreamhearth.org>

# System setup & requirements
RUN apt-get update && \
    apt-get install -y nginx supervisor php5-fpm php5-mysql && \
    rm -rf /etc/init.d/nginx /etc/init.d/php-fpm

# Configure nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Configure php-fpm
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf && \
    sed -i 's/user = nobody/user = root/g' /etc/php5/fpm/php-fpm.conf
    #sed -i 's/group = nobody/group = root/g' /etc/php/fpm/php-fpm.conf

# Install supervisor
RUN mkdir -p /var/log/supervisor
COPY ./conf/supervisord.conf /etc/supervisord.conf

# RUN cat /etc/php/php-fpm.conf
USER root
CMD ["/usr/bin/supervisord"]
