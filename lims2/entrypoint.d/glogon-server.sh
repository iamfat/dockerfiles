#!/bin/sh

if [ -e "$GLOGON_SERVER_DIR" ]; then
	chown -R genee:admin "$GLOGON_SERVER_DIR"
	su -l -s /bin/sh -c 'cd $GLOGON_SERVER_DIR && npm install' genee
	/bin/sh -c 'cd $GLOGON_SERVER_DIR && ./deploy.sh'
fi
