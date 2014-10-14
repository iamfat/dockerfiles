#!/bin/sh

git clone --branch master /git/epc-server.git epc-server
cd epc-server
cnpm install

config_file=config/default.json
port=3041
[ ! -w $config_file ] || sed -i "s/\(\"rpc_url\".*:\)[0-9]*\"/\1${port}\"/" $config_file
