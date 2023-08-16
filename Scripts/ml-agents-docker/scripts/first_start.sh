#!/bin/bash

set -e

mkdir -p /container_state

if [[ -f /container_state/is_initialized ]]; then
    exit 0
fi

if [[ ! -f /container_state/pwd_set ]]; then
    echo "Setup password for user 'mlagents':"
    passwd mlagents
    touch /container_state/pwd_set
fi

sudo -u mlagents /tmp/scripts/clone_mlagents.sh
sudo -u mlagents /bin/bash -c /tmp/scripts/setup_venv.sh

touch /container_state/is_initialized
