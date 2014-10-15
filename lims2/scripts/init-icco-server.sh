#!/bin/sh

git clone --branch master /git/icco-server.git icco-server
cd icco-server
cnpm install

config_file=config/default.js
icco_server_port=2333
icco_agent_port=2332
[ ! -w $config_file ] || sed -i "
	s/\(\"port\"[^0-9]*\)[0-9]*/\1${icco_server_port}/
	s/\(\"service_port\"[^0-9]*\)[0-9]*/\1${icco_server_port}/
	s/\(\"agent_port\"[^0-9]*\)[0-9]*/\1${icco_agent_port}/
" $config_file
