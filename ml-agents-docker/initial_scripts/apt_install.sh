#!/bin/bash

set -e

CURRENT_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

SUDO=""

# only use sudo if we are not root
if [ "$UID" -ne 0 ]; then
    SUDO="sudo"
fi

echo "Install $@"

$SUDO apt-get update
$SUDO apt-get install -y $@

"$CURRENT_SCRIPT_DIR"/apt_clean.sh
