#!/bin/bash

# This scripts runs when we ssh into raspberry pi

set -o errexit -o nounset -o pipefail -o xtrace

SERVICE_NAME=$1
SERVICE_PATH=/etc/systemd/system/${SERVICE_NAME}

# cleanup () {
#   sudo rm ${SERVICE_PATH}
# }

# trap cleanup EXIT
SUCCESS=0

if [ ! -f ${SERVICE_PATH} ];then
  echo -e "\n[***] Service Does Not Exist...Creating...\n"

  sudo cp /tmp/${SERVICE_NAME} ${SERVICE_PATH}

  sudo systemctl daemon-reload && \
    sudo systemctl enable ${SERVICE_NAME} && \
    sudo systemctl start ${SERVICE_NAME} && \
    SUCCESS=1

  if [[ "${SUCCESS}" -eq 0 ]]; then
    sudo rm ${SERVICE_PATH}
  fi
else
  echo -e "\n[***] Service Exists...Restarting...\n"

  sudo systemctl restart ${SERVICE_NAME}
fi
