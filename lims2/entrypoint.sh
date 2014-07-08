#!/bin/sh

for ep in /entrypoint.d/* ; do
	[ ! -x "$ep" ] || eval "$ep"
done
exec "$@"
