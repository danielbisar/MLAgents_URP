#!/bin/bash

RUN_ID="$1"

SCRIPT_LOCATION="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

pushd "$SCRIPT_LOCATION"

. ../venv/bin/activate
mlagents-learn --run-id "$RUN_ID" --num-areas 8 ./configs/agent_01.yaml --force

popd
