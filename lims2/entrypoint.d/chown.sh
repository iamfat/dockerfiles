#!/bin/sh

for p in ${DOCKER_LIMS2_DIR} ${DOCKER_LABS_DIR} ${DOCKER_CACHE_DIR} ; do
	[ -e "$p" ] || mkdir -p "$p"
	chown -R www-data:www-data "$p"
done
