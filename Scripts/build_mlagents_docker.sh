#!/bin/bash

LOCAL_SCRIPT_DIR="$(cd $(dirname "$BASH_SOURCE") && pwd)"

pushd "$LOCAL_SCRIPT_DIR/../ml-agents-docker"

#echo "Check for old containers..."
# if [[ $(docker ps -a -f name=mlagents --format '{{.ID}}' | wc -l) -gt 0 ]]; then
#     echo "Remove old containers"
#
#     for id in $(docker ps -a -f name=mlagents --format '{{.ID}}'); do
#         docker container rm $id
#     done
# fi

docker build "$@" -t mlagents --build-arg USER_ID=$UID --build-arg USER_GROUP_ID=$(id -g $USER) .

popd
