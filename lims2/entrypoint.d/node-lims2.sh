#!/bin/sh

d=$DOCKER_NODE_LIMS2_DIR

if [ -e "$d" ]; then
	chown -R genee:admin "$d"
	su -l -s /bin/sh -c "cd $d && npm install" genee
	/bin/sh -c "cd $d && ./deploy.sh"
fi

logdir=$DOCKER_NODE_LIMS2_LOG_DIR
[ -e "$logdir" ] || mkdir -p "$logdir"
chown -R genee:admin "$logdir"
