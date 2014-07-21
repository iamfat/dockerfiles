#!/bin/sh

(
	sleep 3
	php ${DOCKER_LIMS2_DIR}/cli/get_cron.php -u genee > /etc/cron.d/lims2
) &
