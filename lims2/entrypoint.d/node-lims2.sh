#!/bin/sh

if [ -e "$NODE_LIMS2_DIR" ]; then
	chown -R genee:admin "$NODE_LIMS2_DIR"
	su -l -s /bin/sh -c 'cd $NODE_LIMS2_DIR && npm install' genee
	/bin/sh -c 'cd $NODE_LIMS2_DIR && ./deploy.sh'
fi

[ -e "$NODE_LIMS2_LOG_DIR" ] || mkdir -p "$NODE_LIMS2_LOG_DIR"
chown -R genee:admin "$NODE_LIMS2_LOG_DIR"
