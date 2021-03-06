FROM ubuntu:14.04
MAINTAINER maintain@geneegroup.com

# Use faster APT mirror
ADD sources.list /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive

# Install Basic Packages
RUN apt-get update && apt-get install -y language-pack-en bash-completion

# Add PPAs
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:builds/sphinxsearch-beta
RUN add-apt-repository ppa:chris-lea/zeromq
RUN apt-get update

# Install Supervisor
RUN apt-get install -y supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install SSH Server
ENV GENEE_PASSWORD 83719730
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && groupadd -f admin && \
    useradd -g admin -m -s /bin/bash -p $(perl -e 'print crypt("'$GENEE_PASSWORD'", "GENEE")') genee
ADD supervisor.ssh.conf /etc/supervisor/conf.d/ssh.conf

# Install xinetd
RUN apt-get install -y xinetd
ADD supervisor.xinetd.conf /etc/supervisor/conf.d/xinetd.conf

# Install slapd
RUN apt-get install -y slapd
ADD supervisor.slapd.conf /etc/supervisor/conf.d/slapd.conf

# Install PHP 5.5
RUN apt-get install -y php5-fpm php5-cli php5-gd php5-mcrypt php5-mysqlnd php5-sqlite php5-curl php5-msgpack php5-ldap libyaml-0-2 && \
    sed -i 's/^listen\s*=.*$/listen = 0.0.0.0:9000/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/fpm/php.ini && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/cli/php.ini
ADD supervisor.php5-fpm.conf /etc/supervisor/conf.d/php5-fpm.conf

ADD yaml.so /usr/lib/php5/20121212/yaml.so
RUN echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini && \
    php5enmod yaml
    
ADD lua.so /usr/lib/php5/20121212/lua.so
RUN apt-get install -y liblua5.2-0 && \
    echo "extension=lua.so" > /etc/php5/mods-available/lua.ini && \
    php5enmod lua
    
ADD zmq.so /usr/lib/php5/20121212/zmq.so
RUN apt-get install -y libzmq3 && \
    echo "extension=zmq.so" > /etc/php5/mods-available/zmq.ini && \
    php5enmod zmq

# Install NodeJS, use CNPM source for faster speed in CHINA...
RUN apt-get install -y npm && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g cnpm --registry=http://r.cnpmjs.org && \
    cnpm install -g less uglify-js

# Install Nginx
RUN apt-get install -y nginx-light && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf
ADD supervisor.nginx.conf /etc/supervisor/conf.d/nginx.conf

# Install Development Tools
RUN apt-get install -y git

# Install Composer
RUN apt-get install -y wget
RUN mkdir -p /usr/local/bin && wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar && \
    chmod +x /usr/local/bin/composer && \
    echo 'export COMPOSER_HOME="/usr/local/share/composer"' > /etc/profile.d/composer.sh && \
    echo 'export PATH="/usr/local/share/composer/vendor/bin:$PATH"' >> /etc/profile.d/composer.sh
ENV COMPOSER_PROCESS_TIMEOUT 40000
ENV COMPOSER_HOME /usr/local/share/composer

# Install fasd for faster directory change
RUN git clone https://github.com/clvv/fasd.git fasd && \
    make -C fasd install && echo 'eval "$(fasd --init auto)"' >> /home/genee/.profile && rm -rf fasd

# Install MySQL Client
RUN apt-get install -y mysql-client

# Install Memcached
RUN apt-get install -y php5-memcache memcached
ADD supervisor.memcached.conf /etc/supervisor/conf.d/memcached.conf

# Install Beanstalkd
RUN apt-get install -y beanstalkd
ADD supervisor.beanstalkd.conf /etc/supervisor/conf.d/beanstalkd.conf

# Install sphinxsearch
RUN apt-get install -y sphinxsearch
ADD sphinx.conf sphinx.conf.sh /etc/sphinxsearch/
ADD supervisor.sphinxsearch.conf /etc/supervisor/conf.d/sphinxsearch.conf

# Install cron
RUN apt-get install -y cron
ADD supervisor.cron.conf /etc/supervisor/conf.d/cron.conf

# Install redis
RUN apt-get install -y redis-server
ADD supervisor.redis.conf /etc/supervisor/conf.d/redis.conf

# Install clamav so that we can scan virus
RUN apt-get install -y --no-install-recommends clamav clamav-freshclam
ADD freshclam.conf /etc/clamav/
RUN freshclam

# Install msmtp
RUN apt-get install -y msmtp-mta mailutils

# Install easyrun
RUN npm install -g genee-easyrun
ADD supervisor.easyrun.conf /etc/supervisor/conf.d/easyrun.conf

# Add all git repos
ADD git /git
ADD scripts /tmp/scripts

# Install node-lims2
RUN apt-get install -y nodejs beanstalkd build-essential
ADD supervisor.node-lims2.conf /etc/supervisor/conf.d/node-lims2.conf
RUN sudo -u genee -i /tmp/scripts/init-node-lims2.sh
RUN mkdir -p /var/log/node-lims2
RUN chown -R genee:admin /var/log/node-lims2

# Install zeromq
RUN apt-get install -y build-essential php-pear php5-dev
RUN apt-get install -y libzmq3-dev libpgm-dev pkg-config

# Install glogon-server
ADD supervisor.glogon-server.conf /etc/supervisor/conf.d/glogon-server.conf
RUN sudo -u genee -i /tmp/scripts/init-glogon-server.sh

# Install epc-server
ADD supervisor.epc-server.conf /etc/supervisor/conf.d/epc-server.conf
RUN sudo -u genee -i /tmp/scripts/init-epc-server.sh

# Install icco-server
ADD supervisor.icco-server.conf /etc/supervisor/conf.d/icco-server.conf
RUN sudo -u genee -i /tmp/scripts/init-icco-server.sh

# Install env-server
ADD supervisor.env-server.conf /etc/supervisor/conf.d/env-server.conf
RUN sudo -u genee -i /tmp/scripts/init-env-server.sh

# Install cacs-server
ADD supervisor.cacs-server.conf /etc/supervisor/conf.d/cacs-server.conf
RUN sudo -u genee -i /tmp/scripts/init-cacs-server.sh

# Install gdoor-server
ADD supervisor.gdoor-server.conf /etc/supervisor/conf.d/gdoor-server.conf
RUN sudo -u genee -i /tmp/scripts/init-gdoor-server.sh

# Install reserv-server
ADD supervisor.reserv-server.conf /etc/supervisor/conf.d/reserv-server.conf
RUN mkdir -p /var/log/reserv-lims2 && chown -R genee:admin /var/log/reserv-lims2
RUN sudo -u genee -i /tmp/scripts/init-reserv-server.sh

# Remove git repos
RUN rm -rf /git
RUN rm -rf /tmp/scripts

# Install Friso && Robbe
ADD libfriso.so /usr/lib/libfriso.so
ADD robbe.so /usr/lib/php5/20121212/robbe.so
RUN echo "extension=robbe.so" > /etc/php5/mods-available/robbe.ini && \
    echo "[robbe]" >> /etc/php5/mods-available/robbe.ini && \
    echo "robbe.ini_file=/etc/friso/friso.ini" >> /etc/php5/mods-available/robbe.ini && \
    php5enmod robbe

RUN apt-get clean

VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

EXPOSE 11300
EXPOSE 9000
EXPOSE 80
EXPOSE 22

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
