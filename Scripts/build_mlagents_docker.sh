#!/bin/bash

LOCAL_SCRIPT_DIR="$(cd $(dirname "$BASH_SOURCE") && pwd)"

pushd $LOCAL_SCRIPT_DIR/ml-agents-docker 2>/dev/null

echo "Delete old container"
if [[ $(docker ps -a -f name=mlagents --format '{{.ID}}' | wc -l) -gt 0 ]]; then
    for id in $(docker ps -a -f name=mlagents --format '{{.ID}}'); do
        docker container rm $id
    done
fi

docker build "$@" -t mlagents --build-arg USER_ID=$UID --build-arg USER_GROUP_ID=$(id -g $USER) .

popd 2>/dev/null
