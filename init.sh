#!/bin/bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CALL_DIR="$(pwd)"

pushd $REPO_DIR > /dev/null
    git pull origin main > /dev/null
    # cp README.md $CALL_DIR/READ2
popd
