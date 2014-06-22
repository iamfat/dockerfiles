FROM ubuntu:12.04
MAINTAINER maintain@geneegroup.com

# Use faster APT mirror
ADD sources.list /etc/apt/sources.list

# Install Basic Packages
RUN apt-get update && apt-get install -y apt-utils sudo vim-tiny language-pack-en bash-completion

# Install Supervisor
RUN apt-get install -y supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install SSH Server
ENV GENEE_PASSWORD 83719730
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && groupadd -f admin && \
    useradd -g admin -m -s /bin/bash -p $(perl -e 'print crypt("'$GENEE_PASSWORD'", "GENEE")') genee
ADD supervisor.ssh.conf /etc/supervisor/conf.d/ssh.conf

# Install PHP 5.4
ADD php5-oldstable.list /etc/apt/sources.list.d/php5-oldstable.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C && apt-get update && \
    apt-get install -y php5-fpm php5-cli php5-gd php5-mcrypt php5-mysqlnd php5-xcache php5-sqlite php5-curl && \
    sed -i 's/^listen\s*=.*$/listen = 0.0.0.0:9000/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/fpm/php.ini && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/cli/php.ini
ADD supervisor.php5-fpm.conf /etc/supervisor/conf.d/php5-fpm.conf

ADD yaml.so /usr/lib/php5/20100525/yaml.so
RUN apt-get install -y libyaml-0-2 && \
    echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini && \
    php5enmod yaml
    
ADD lua.so /usr/lib/php5/20100525/lua.so
RUN apt-get install -y liblua5.2-0 && \
    echo "extension=lua.so" > /etc/php5/mods-available/lua.ini && \
    php5enmod lua
    
ADD zmq.so /usr/lib/php5/20100525/zmq.so
RUN apt-get install -y libzmq3 && \
    echo "extension=zmq.so" > /etc/php5/mods-available/zmq.ini && \
    php5enmod zmq
    
ADD msgpack.so /usr/lib/php5/20100525/msgpack.so
RUN echo "extension=msgpack.so" > /etc/php5/mods-available/msgpack.ini && \
    php5enmod msgpack
    
# Install NodeJS, use CNPM source for faster speed in CHINA...
ADD nodejs.list /etc/apt/sources.list.d/nodejs.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12 && apt-get update && \
    apt-get install -y nodejs && \
    npm install -g cnpm --registry=http://r.cnpmjs.org && \
    cnpm install -g less uglify-js

# Install Nginx
RUN apt-get install -y nginx-light && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf
ADD supervisor.nginx.conf /etc/supervisor/conf.d/nginx.conf

# Install Development Tools
RUN apt-get install -y git build-essential

# Install Composer
RUN mkdir -p /usr/local/bin && php -r "readfile('https://getcomposer.org/installer');" | php && \
    mv composer.phar /usr/local/bin/composer && \
    echo 'export COMPOSER_HOME="/usr/local/share/composer"' > /etc/profile.d/composer.sh && \
    echo 'export PATH="/usr/local/share/composer/vendor/bin:$PATH"' >> /etc/profile.d/composer.sh
ENV COMPOSER_PROCESS_TIMEOUT 40000
ENV COMPOSER_HOME /usr/local/share/composer

VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

EXPOSE 9000
EXPOSE 80
EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
