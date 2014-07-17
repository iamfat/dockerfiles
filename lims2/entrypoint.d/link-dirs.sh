#!/bin/sh

prefix=$DOCKER_LIMS2_DIR

lab_link=${prefix}/sites/lab
rm -rf ${lab_link}
ln -s ${DOCKER_LAB_DIR} ${lab_link}

cache_link=${prefix}/public/cache
rm -rf ${cache_link}
ln -s ${DOCKER_CACHE_DIR} ${cache_link}
