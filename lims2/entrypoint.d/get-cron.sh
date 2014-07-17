#!/bin/sh

(
	sleep 3
	php /usr/local/share/lims2/cli/get_cron.php -u genee > /etc/cron.d/lims2
) &
