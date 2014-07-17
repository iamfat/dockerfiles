#!/bin/sh

d=$DOCKER_GLOGON_SERVER_DIR
if [ -e "$d" ]; then
	chown -R genee:admin "$d"
	su -l -s /bin/sh -c "cd $d && npm install" genee
	/bin/sh -c "cd $d && ./deploy.sh"
fi
