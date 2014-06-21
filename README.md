dockerfiles
===========

My Dockerfiles

## Gini Environment (Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini gini
docker run --name gini -v /dev/log:/dev/log -v /data:/data \
	-v /data/config/sites:/etc/nginx/sites-enabled \
	-v /data/logs/nginx:/var/log/nginx \
	-p 80:80 \
	-d iamfat/gini
```
## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini-dev gini-dev

#simple way
docker run --name gini-dev -v /dev/log:/dev/log -v /data:/data \
	-v /data/config/sites:/etc/nginx/sites-enabled \
	-v /data/logs/nginx:/var/log/nginx \
	-p 80:80 \
	-d iamfat/gini-dev

# more advanced way
docker run --name gini-dev -v /dev/log:/dev/log -v /data:/data \
	-v /data/config/sites:/etc/nginx/sites-enabled \
	-v /data/logs/nginx:/var/log/nginx \
	-p 80:80 \
	-d iamfat/gini-dev
```
## MySQL Environment (MySQL + SSH)
```bash
docker build -t iamfat/mysql mysql

#simple way
docker run --name mysql -v /dev/log:/dev/log -v /data:/data -d iamfat/mysql

# more advanced way
docker run --name mysql -v /dev/log:/dev/log -v /data:/data \
	-v /data/config/mysql:/etc/mysql
	-v /data/mysql:/var/lib/mysql
	-d iamfat/mysql
```
## Redis Environment (Redis + SSH)
```bash
docker build -t iamfat/redis redis
docker run --name redis -v /dev/log:/dev/log -v /data:/data -d iamfat/redis
```

## Sphinx Search Environment (SphinxSearch + SSH)
```bash
docker build -t iamfat/sphinxsearch sphinxsearch

#simple way
docker run --name sphinxsearch -v /dev/log:/dev/log -v /data:/data -d iamfat/sphinxsearch

# more advanced way
docker run --name sphinxsearch -v /dev/log:/dev/log -v /data:/data \
	-v /data/config/sphinxsearch:/etc/sphinxsearch
	-v /data/sphinxsearch:/var/lib/sphinxsearch
	-d iamfat/sphinxsearch
```
