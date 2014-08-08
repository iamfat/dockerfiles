My Dockerfiles
===========

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
    --link mall-mysql:mysql --link mall-sphinx:sphinx
    -d iamfat/mall-old
```
