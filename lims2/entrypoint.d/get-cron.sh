#!/bin/sh

(
	sleep 3
	SITE_ID=$SITE_ID LAB_ID=$LAB_ID php /usr/local/share/lims2/cli/get_cron.php -u genee > /etc/cron.d/lims2
) &
