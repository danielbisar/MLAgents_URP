#!/bin/bash

set -e

TIMEZONE="Europe/Berlin"

echo "Setup timezone to $TIMEZONE"

ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
