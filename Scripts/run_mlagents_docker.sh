#!/bin/bash

LOCAL_SCRIPT_DIR="$(cd $(dirname "$BASH_SOURCE") && pwd)"

pushd "$LOCAL_SCRIPT_DIR/../ml-agents-docker"

mkdir -p ./home/src/venv
mkdir -p ./home/.cache/pip

docker run --network=host \
    --rm \
    -v ./home/src/ml-agents:/home/mlagents/src/ml-agents \
    -v ./home/src/venv:/home/mlagents/src/venv \
    -v ./home/.cache/pip:/home/mlagents/.cache/pip \
    -it --name mlagents_container mlagents

popd
