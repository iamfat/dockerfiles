#!/bin/sh

git clone /git/env-server.git env-server
cd env-server
cnpm install

config_file=config/default.json
port=3741
[ ! -w $config_file ] || sed -i "s/\(\"rpc_url\".*:\)[0-9]*\"/\1${port}\"/" $config_file
