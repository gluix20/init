#!/bin/bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CALL_DIR="$(pwd)"

pushd $REPO_DIR > /dev/null
  git pull origin main > /dev/null
  if [ "$1" == "load" ]; then
    cp -r load/* $CALL_DIR/.
  fi

  if [ "$1" == "pod" ]; then
    cp -r pod/* $CALL_DIR/.
  fi

  if [ "$1" == "build_image" ]; then
    cp -r build_image/* $CALL_DIR/.
  fi
popd
