#!/bin/sh

sed -i "s|\(\$config\['root'\]=.*\)://\(genee.*@[^/]*\)/|\1://genee:83719730@mysql/|" ${LIMS2_DIR}/application/config/database.php
