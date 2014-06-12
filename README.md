dockerfiles
===========

My Dockerfiles

## Gini Environment (Gini + Composer + PHP5.5 + Nginx + SSH)
## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini-dev gini-dev
docker run --name gini-dev -v /dev/log:/dev/log -v /vagrant/data:/data -d iamfat/gini-dev
```
## MySQL Environment (MySQL + SSH)
## Redis Environment (Redis + SSH)