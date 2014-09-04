#!/bin/sh

git clone /git/cacs-server.git cacs-server
cd cacs-server
cnpm install

config_file=config/default.js
port=2530
[ ! -w config/default.js ] || sed -i "s/\(port:[^0-9]*\)[0-9]*\"/\1${port}\"/" config/default.js
