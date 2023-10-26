#!/bin/bash

set -e

pushd ~/src/venv

#if [ -d venv ]; then
#    echo "Found previous venv. Skip creating. Delete /tmp from this repo to recreate the venv."
#else
    python3.9 -m venv .
#fi

. ./bin/activate

# mkdir -p /tmp/pip_install && cd /tmp/pip_install
# echo "Download pip installer..."
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# echo "Install pip"
# python3.9 get-pip.py
# rm -rf /tmp/pip_install

echo "Install required packages"
# requires Python Version >=3.8.13,<=3.10.8;
pip install mlagents==0.30.0
# will also install
# Collecting torch<=1.11.0,>=1.8.0 (from mlagents==0.30.0)
#   Downloading torch-1.11.0-cp310-cp310-manylinux1_x86_64.whl (750.6 MB)

# fix protobuf version; 4.23.2 which was installed, due to an incorrect dependency statement (protobuf>=3.6)
# mlagents does not work with that, so we downgrade to a working version
pip install protobuf~=3.20.0 --upgrade

echo "Done"

mlagents-learn --help

popd
