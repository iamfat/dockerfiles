FROM iamfat/gini
MAINTAINER maintain@geneegroup.com

# Install XDebug
RUN apt-get install -y php5-xdebug

# Install test-helpers
ADD test_helpers.so /usr/lib/php5/20121212/test_helpers.so
RUN echo "zend_extension=test_helpers.so" > /etc/php5/mods-available/test_helpers.ini && \
    php5enmod test_helpers

# Install PHPUnit and PHP-CS-Fixer
RUN composer global require 'phpunit/phpunit:@stable' 'fabpot/php-cs-fixer:@stable' --prefer-dist

# Install fasd for faster directory change
RUN git clone https://github.com/clvv/fasd.git fasd && \
    make -C fasd install && echo 'eval "$(fasd --init auto)"' >> /home/genee/.profile && rm -rf fasd

# Add git prompt for genee
ADD git_prompt.sh /home/genee/.git_prompt && echo '. $HOME/.git_prompt' >> /home/genee/.profile


VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]

EXPOSE 9000
EXPOSE 80
EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]
