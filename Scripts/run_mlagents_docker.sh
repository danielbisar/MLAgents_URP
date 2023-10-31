#!/bin/bash

LOCAL_SCRIPT_DIR="$(cd $(dirname "$BASH_SOURCE") && pwd)"

pushd "$LOCAL_SCRIPT_DIR/../ml-agents-docker"

mkdir -p ./home/src/venv
mkdir -p ./home/.cache/pip

# ./home/src cannot be used directly, since ml-agents is a symlink
# TODO check if ml-agents folder is required at all inside the container
docker run -p 5004:5004 \
    --rm \
    -v ./home/src/ml-agents:/home/mlagents/src/ml-agents \
    -v ./home/src/venv:/home/mlagents/src/venv \
    -v ./home/src/learn:/home/mlagents/src/learn \
    -v ./home/.cache/pip:/home/mlagents/.cache/pip \
    -it --name mlagents_container mlagents

popd
