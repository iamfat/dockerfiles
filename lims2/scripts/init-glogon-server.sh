#!/bin/sh

git clone --branch master /git/glogon-server.git glogon-server
cd glogon-server
cnpm install

config_file=config/default.js
glogon_port=2430
[ ! -w $config_file ] || sed -i "s/\(my_port:[^0-9]*\)[0-9]*/\1${glogon_port}/" $config_file
