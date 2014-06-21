FROM ubuntu:14.04
MAINTAINER jia.huang@geneegroup.com

# Use faster APT mirror
ADD sources.list /etc/apt/sources.list

# Install Basic Packages
RUN apt-get update && apt-get install -y language-pack-en

# Install Supervisor
RUN apt-get install -y supervisor && \
    sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install SSH Server
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && groupadd -f admin && \
    useradd -g admin -m -s /bin/bash -p $(perl -e 'print crypt("83719730", "GENEE")') genee
ADD supervisor.ssh.conf /etc/supervisor/conf.d/ssh.conf

# Install Sphinxsearch Server
ADD sphinxsearch-beta.list /etc/apt/sources.list.d/sphinxsearch-beta.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9D8946B16932B16 && \
	apt-get update && apt-get install -y sphinxsearch && \
	mkdir -p /etc/sphinxsearch/conf.d
ADD supervisor.sphinxsearch.conf /etc/supervisor/conf.d/sphinxsearch.conf
ADD sphinx.conf.sh /etc/sphinxsearch/sphinx.conf.sh

VOLUME ["/data", "/etc/sphinxsearch", "/var/lib/sphinxsearch"]

# Sphinx Plain Port
EXPOSE 9312
# SphinxQL Port
EXPOSE 9306
# SSH
EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord"]
CMD ["-c", "/etc/supervisor/supervisord.conf"]