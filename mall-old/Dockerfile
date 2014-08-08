FROM ubuntu:14.04
MAINTAINER maintain@geneegroup.com

# Use faster APT mirror
ADD sources.list /etc/apt/sources.list

# Install Basic Packages
RUN apt-get update && apt-get install -y language-pack-en bash-completion

# Install Supervisor
RUN apt-get install -y supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install PHP 5.5
RUN apt-get install -y php5-fpm php5-cli php5-gd php5-mcrypt php5-mysqlnd php5-ldap php5-sqlite php5-curl libyaml-0-2 && \
    sed -i 's/^listen\s*=.*$/listen = 0.0.0.0:9000/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/fpm/php.ini && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/cli/php.ini
ADD supervisor.php5-fpm.conf /etc/supervisor/conf.d/php5-fpm.conf

ADD yaml.so /usr/lib/php5/20121212/yaml.so
RUN echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini && \
    php5enmod yaml
    
# Install NodeJS, use CNPM source for faster speed in CHINA...
RUN apt-get install -y npm && ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g less uglify-js

# Install Nginx
RUN apt-get install -y nginx-light && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf
ADD supervisor.nginx.conf /etc/supervisor/conf.d/nginx.conf

# Install Development Tools
RUN apt-get install -y git

# Install Composer
RUN mkdir -p /usr/local/bin && php -r "readfile('https://getcomposer.org/installer');" | php && \
    mv composer.phar /usr/local/bin/composer && \
    echo 'export COMPOSER_HOME="/usr/local/share/composer"' > /etc/profile.d/composer.sh && \
    echo 'export PATH="/usr/local/share/composer/vendor/bin:$PATH"' >> /etc/profile.d/composer.sh
ENV COMPOSER_PROCESS_TIMEOUT 40000
ENV COMPOSER_HOME /usr/local/share/composer

# Install MySQL Client
RUN apt-get install -y mysql-client

# Install Memcached
RUN apt-get install -y php5-memcache memcached
ADD supervisor.memcached.conf /etc/supervisor/conf.d/memcached.conf

# Install Friso && Robbe
ADD libfriso.so /usr/lib/libfriso.so
ADD robbe.so /usr/lib/php5/20121212/robbe.so
RUN echo "extension=robbe.so" > /etc/php5/mods-available/robbe.ini && \
    echo "[robbe]" >> /etc/php5/mods-available/robbe.ini && \
    echo "robbe.ini_file=/etc/friso/friso.ini" >> /etc/php5/mods-available/robbe.ini && \
    php5enmod robbe

# VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx", "/etc/friso"]

EXPOSE 9000
EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
