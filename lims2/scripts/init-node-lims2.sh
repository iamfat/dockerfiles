#!/bin/sh

git clone /git/node-lims2.git node-lims2
cd node-lims2
cnpm install

sed -i 's|\("log_dir": *\)"[^"]*"|\1"/var/log/node-lims2/"|' config/default.json
