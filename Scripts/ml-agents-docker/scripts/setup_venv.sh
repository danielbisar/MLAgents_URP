#!/bin/bash

set -e

cd ~/src

if [ -d ~/src/venv ]; then
    echo "Found previous venv, remove"
    rm -rf ~/src/venv
fi

python3.9 -m venv venv
. ~/src/venv/bin/activate

mkdir -p /tmp/pip_install && cd /tmp/pip_install
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.9 get-pip.py

# requires Python Version >=3.8.13,<=3.10.8;
pip install mlagents==0.30.0
# will also install
# Collecting torch<=1.11.0,>=1.8.0 (from mlagents==0.30.0)
#   Downloading torch-1.11.0-cp310-cp310-manylinux1_x86_64.whl (750.6 MB)

# fix protobuf version; 4.23.2 which was installed, due to an incorrect dependency statement (protobuf>=3.6)
# mlagents does not work with that, so we downgrade to a working version
pip install protobuf~=3.20.0 --upgrade

mlagents-learn --help
