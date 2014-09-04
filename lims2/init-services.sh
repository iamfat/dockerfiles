#!/bin/sh

serv=${1}

git clone /git/${serv}.git ${serv}
cd ${serv}
cnpm install
