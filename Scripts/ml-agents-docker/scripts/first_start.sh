#!/bin/bash

if [[ -f /is_initialized ]]; then
    exit 0
fi

echo "Setup password for user:"
passwd mlagents

sudo -u mlagents /tmp/scripts/clone_mlagents.sh
sudo -u mlagents /bin/bash -c /tmp/scripts/setup_venv.sh
