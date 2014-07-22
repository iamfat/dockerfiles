#!/bin/sh

prefix=$DOCKER_LIMS2_DIR

labs_link=${prefix}/sites/${SITE_ID}/labs
rm -rf ${labs_link}
ln -s ${DOCKER_LABS_DIR} ${labs_link}

cache_link=${prefix}/public/cache
rm -rf ${cache_link}
ln -s ${DOCKER_CACHE_DIR} ${cache_link}
