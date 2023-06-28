#!/bin/bash

set -e

cd ~/src

if [ -d ~/src/venv ]; then
    echo "Found previous venv, remove"
    rm -rf ~/src/venv
fi

python3 -m venv venv
. ~/src/venv/bin/activate
pip install pip --upgrade

pip install mlagents==0.30.0
# will also install
# Collecting torch<=1.11.0,>=1.8.0 (from mlagents==0.30.0)
#   Downloading torch-1.11.0-cp310-cp310-manylinux1_x86_64.whl (750.6 MB)

# fix protobuf version; 4.23.2 will due to an incorrect dependencey statement saying protobuf>=3.6
# mlagents does not work with that, so we downgrade to a working version
pip install protobuf~=3.20.0 --upgrade

mlagents-learn --help
