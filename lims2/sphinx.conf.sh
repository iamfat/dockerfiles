#!/bin/bash

set -e

cd "$(dirname $0)"
cat sphinx.conf
[ ! -d conf.d ] || find conf.d -type f -name '*.conf' -execdir cat {} +
