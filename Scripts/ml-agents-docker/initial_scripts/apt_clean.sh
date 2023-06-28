#!/bin/bash

set -e

SUDO=""

# only use sudo if we are not root
if [ "$UID" -ne 0 ]; then
    SUDO="sudo"
fi

echo "Clean apt cache."
$SUDO apt-get clean
$SUDO rm -rf /var/lib/apt/lists/*

function delete_if_exists()
{
    if [ -f "$1" ]; then
        $SUDO rm "$1"
    fi
}

delete_if_exists /var/cache/debconf/templates.dat
delete_if_exists /var/cache/debconf/templates.dat-old
delete_if_exists /var/log/dpkg.log
