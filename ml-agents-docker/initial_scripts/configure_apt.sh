#!/bin/bash

set -e

echo "Disable suggested and recommendend auto package installation"
echo -e "APT::Install-Recommends \"0\";\\nAPT::Install-Suggests \"0\";\\n" \
    >/etc/apt/apt.conf.d/00_apt_config

/tmp/scripts/apt_clean.sh
