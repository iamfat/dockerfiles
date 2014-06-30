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

## LIMS2 Environment
```bash
docker build -t iamfat/lims2 lims2

export BASE_DIR=/data/lims2

docker run --name lims2-sphinx -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/config/sphinxsearch:/etc/sphinxsearch \
    -v $BASE_DIR/sphinxsearch:/var/lib/sphinxsearch \
    -v $BASE_DIR/logs/sphinxsearch:/var/log/sphinxsearch \
    -d iamfat/sphinxsearch

docker run --name lims2-mysql -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/config/mysql:/etc/mysql \
    -v $BASE_DIR/mysql:/var/lib/mysql \
    -v $BASE_DIR/logs/mysql:/var/log/mysql \
    -d iamfat/mysql

docker run --name lims2 -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/config/sites:/etc/nginx/sites-enabled \
    -v $BASE_DIR/logs/nginx:/var/log/nginx \
    -v $BASE_DIR/lims2:/usr/local/share/lims2 \
    -d iamfat/lims2
```

## Mall Old Environment
```bash
docker build -t iamfat/mall-old mall-old

export BASE_DIR=/data/mall-old

docker run --name mall-old-sphinx -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/config/sphinxsearch:/etc/sphinxsearch \
    -v $BASE_DIR/sphinxsearch:/var/lib/sphinxsearch \
    -v $BASE_DIR/logs/sphinxsearch:/var/log/sphinxsearch \
    -d iamfat/sphinxsearch

docker run --name mall-old-mysql -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/config/mysql:/etc/mysql \
    -v $BASE_DIR/mysql:/var/lib/mysql \
    -v $BASE_DIR/logs/mysql:/var/log/mysql \
    -d iamfat/mysql

docker run --name mall-old -v /dev/log:/dev/log -v $BASE_DIR:/data --privileged \
    -v $BASE_DIR/config/sites:/etc/nginx/sites-enabled \
    -v $BASE_DIR/logs/nginx:/var/log/nginx \
    -v $BASE_DIR/mall-old:/usr/local/share/mall \
    -d iamfat/mall-old
```
