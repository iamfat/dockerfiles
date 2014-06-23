My Dockerfiles
===========

## Gini Environment (Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini gini
docker run --name gini -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/sites:/etc/nginx/sites-enabled \
    -v /data/logs/nginx:/var/log/nginx \
    -p 80:80 \
    -d iamfat/gini
```
## Gini Dev Environment (PHPUnit + Gini + Composer + PHP5.5 + Nginx + SSH)
```bash
docker build -t iamfat/gini-dev gini-dev

docker run --name gini-dev -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/sites:/etc/nginx/sites-enabled \
    -v /data/logs/nginx:/var/log/nginx \
    -p 80:80 \
    -d iamfat/gini-dev
```
## MySQL Environment (MySQL + SSH)
```bash
docker build -t iamfat/mysql mysql

#simple way
docker run --name mysql -v /dev/log:/dev/log -v /data:/data --privileged -d iamfat/mysql

# more advanced way
docker run --name mysql -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/mysql:/etc/mysql \
    -v /data/mysql:/var/lib/mysql \
    -d iamfat/mysql
```
## Redis Environment (Redis + SSH)
```bash
docker build -t iamfat/redis redis

#simple way
docker run --name redis -v /dev/log:/dev/log -v /data:/data --privileged -d iamfat/redis

# more advanced way
docker run --name redis -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/redis:/etc/redis \
    -d iamfat/redis
```

## Sphinx Search Environment (SphinxSearch + SSH)
```bash
docker build -t iamfat/sphinxsearch sphinxsearch

#simple way
docker run --name sphinxsearch -v /dev/log:/dev/log -v /data:/data --privileged -d iamfat/sphinxsearch

# more advanced way
docker run --name sphinxsearch -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/sphinxsearch:/etc/sphinxsearch \
    -v /data/sphinxsearch:/var/lib/sphinxsearch \
    -d iamfat/sphinxsearch
```

## LIMS Base Environment (PHP + NGINX + SSH)
```bash
docker build -t iamfat/lims-base lims-base

#simple way
docker run --name lims -v /dev/log:/dev/log -v /data:/data --privileged -d iamfat/lims-base

# more advanced way
docker run --name lims -v /dev/log:/dev/log -v /data:/data --privileged \
    -v /data/config/sites:/etc/nginx/sites-enabled \
    -v /data/logs/nginx:/var/log/nginx \
    -d iamfat/lims-base
```

## LIMS2 Environment
```bash
docker build -t iamfat/lims2 lims2

export BASE_DIR=/data/lims2
export SITE_ID=cf
export LAB_ID=nankai

docker run --name lims -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/config/sites:/etc/nginx/sites-enabled \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/config/sphinxsearch:/etc/sphinxsearch \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/logs/nginx:/var/log/nginx \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/logs/mysql:/var/log/mysql \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/logs/sphinxsearch:/var/log/sphinxsearch \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/mysql:/var/lib/mysql \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/sphinxsearch:/var/lib/sphinxsearch \
    -d iamfat/lims2

docker run --name lims -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/config/sites:/etc/nginx/sites-enabled \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/config/sphinxsearch:/etc/sphinxsearch \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/logs/nginx:/var/log/nginx \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/logs/mysql:/var/log/mysql \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/logs/sphinxsearch:/var/log/sphinxsearch \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/mysql:/var/lib/mysql \
    -v $BASE_DIR/$SITE_ID/$LAB_ID/sphinxsearch:/var/lib/sphinxsearch \
    -i -t iamfat/lims2 bin/bash
```
