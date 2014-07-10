#!/bin/sh

lab_link=${LIMS2_DIR}/sites/lab
rm -rf ${lab_link}
ln -s ${LAB_DIR} ${lab_link}

cache_link=${LIMS2_DIR}/public/cache
rm -rf ${cache_link}
ln -s ${CACHE_DIR} ${cache_link}
