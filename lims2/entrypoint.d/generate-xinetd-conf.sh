#!/bin/sh

LIMS_DEVICE_FILE=etc/xinetd.d/lims_device
DEST=/${LIMS_DEVICE_FILE}
LIMS_DEVICE_TEMPLATE=${DOCKER_LIMS2_DIR}/sites/${SITE_ID}/labs/${LAB_ID}/${LIMS_DEVICE_FILE}
LIMS_DEVICE_DEFAULT_TEMPLATE=${DOCKER_LIMS2_DIR}/deploy/${LIMS_DEVICE_FILE}

if [ -e "${DEST}" ]; then
	exit 0
elif [ -r "${LIMS_DEVICE_TEMPLATE}" ]; then
	SRC="${LIMS_DEVICE_TEMPLATE}"
elif [ -r "${LIMS_DEVICE_DEFAULT_TEMPLATE}" ]; then
	SRC="${LIMS_DEVICE_DEFAULT_TEMPLATE}"
else
	exit 0
fi

sed "s/%site_id%/${SITE_ID}/ ; s/%lab_id%/${LAB_ID}/" "${SRC}" > "${DEST}"
