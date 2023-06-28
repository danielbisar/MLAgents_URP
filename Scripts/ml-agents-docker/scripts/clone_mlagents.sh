#!/bin/bash

set -e

if [ -d ~/src/ml-agents/com.unity.ml-agents/ ]; then
    exit 0
fi

mkdir -p ~/src/
pushd ~/src/ 2>/dev/null
git clone --branch release_20 https://github.com/Unity-Technologies/ml-agents.git
popd 2>/dev/null
