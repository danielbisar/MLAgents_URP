#!/bin/bash

LOCAL_SCRIPT_DIR="$(cd $(dirname "$BASH_SOURCE") && pwd)"

pushd $LOCAL_SCRIPT_DIR 2>/dev/null
mkdir -p ./mount

if [ $(docker ps -a | grep mlagents_container | wc -l) -gt 0 ]; then
    echo "found container: docker start"
    docker start -ai mlagents_container
else
    echo "container not found: docker run"
    docker run --network=host -v ./mount/:/home/mlagents/src/ -it --name mlagents_container mlagents
fi

popd 2>/dev/null
