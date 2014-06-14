FROM ubuntu:14.04
MAINTAINER maintain@geneegroup.com

# Use faster APT mirror
ADD sources.list /etc/apt/sources.list

# Install Basic Packages
RUN apt-get update && apt-get install -y language-pack-en bash-completion

# Install Supervisor
RUN apt-get install -y supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install SSH Server
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && groupadd -f admin && \
    useradd -g admin -m -s /bin/bash -p $(perl -e 'print crypt("83719730", "GENEE")') genee
ADD supervisor.ssh.conf /etc/supervisor/conf.d/ssh.conf

# Install PHP 5.5
RUN apt-get install -y php5-fpm php5-cli php5-gd php5-mcrypt php5-mysqlnd php5-redis php5-dev php5-sqlite php5-curl libyaml-dev php5-xdebug && \
	printf "\n" | pecl install yaml-beta && \
	echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini && \
	php5enmod yaml && \
    sed -i 's/^listen\s*=.*$/listen = 0.0.0.0:9000/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/fpm/php.ini && \
    sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = syslog/' /etc/php5/cli/php.ini
ADD supervisor.php5-fpm.conf /etc/supervisor/conf.d/php5-fpm.conf
	
# Install NodeJS, use CNPM source for faster speed in CHINA...
RUN apt-get install -y npm && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g cnpm --registry=http://r.cnpmjs.org & \
    cnpm install -g less uglify-js

# Install Nginx
RUN apt-get install -y nginx-light && \
    echo 'daemon off;' >> /etc/nginx/nginx.conf
ADD supervisor.nginx.conf /etc/supervisor/conf.d/nginx.conf

# Install Composer
RUN mkdir -p /usr/local/bin && php -r "readfile('https://getcomposer.org/installer');" | php && \
    mv composer.phar /usr/local/bin/composer && \
    echo '' >> /home/genee/.profile && \
    echo 'PATH="/home/genee/.composer/vendor/bin:$PATH"' >> /home/genee/.profile

# Install Gini
RUN COMPOSER_PROCESS_TIMEOUT=40000 sudo -Hu genee composer global require 'iamfat/gini:dev-master' --prefer-dist

# Install Development Tools    
RUN pear channel-discover pear.phpunit.de && \
    pecl install phpunit/test_helpers && \
    echo "zend_extension=test_helpers.so" > /etc/php5/mods-available/test_helpers.ini && \
    php5enmod test_helpers && \
    COMPOSER_PROCESS_TIMEOUT=40000 sudo -Hu genee composer global require 'phpunit/phpunit:*' --prefer-dist

VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

EXPOSE 9000
EXPOSE 80
EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
