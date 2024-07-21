#!/bin/bash
#v2024-02-27

ROOT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
pushd "$ROOT_DIR" > /dev/null
  
  env_message="value already set"
  if [ -z "$ENV" ]; then
    env_message="set from .env"
    source .env
  fi

  # Parse the YAML, get keys and values, then set and export them as environment variables
  exports=$(yq -r ".shared" load_env_vars.yaml | jq -r 'to_entries|map("export \(.key)=\(.value|tostring)")|.[]')
  exports="$exports $(yq -r ".$ENV" load_env_vars.yaml | jq -r 'to_entries|map("export \(.key)=\(.value|tostring)")|.[]')"
  
  eval "$exports"

  if [ "$1" == "-v" ]; then
    echo "    -------------"
    echo "ENV >>>  ${ENV}  <<< $env_message"
    echo "    -------------"
    echo
    echo "Loaded:" "$exports" | sed 's/ export/\nexport/g'
    echo
  fi
