#!/bin/bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CALL_DIR="$(pwd)"

pushd $REPO_DIR > /dev/null
    git pull origin main > /dev/null
    cp load/* $CALL_DIR/.
    cp build_ice/* $CALL_DIR/.
    cp pod/* $CALL_DIR/.
popd
