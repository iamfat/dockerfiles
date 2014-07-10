#!/bin/sh

for p in ${LIMS2_DIR} ${LAB_DIR} ${CACHE_DIR} ; do
	[ ! -e "$p" ] || chown -R www-data:www-data "$p"
done
