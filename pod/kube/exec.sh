#!/bin/bash
[ -f "load_env.sh" ] && source load_env.sh || source ../load_env.sh

IMAGE_NAME=$(basename "$BUILD_BASE_IMAGE_URI")
OBJ_NAME="${IMAGE_NAME/-image/-test}"

kubectl exec -it -n af-user-jobs $OBJ_NAME -- bash

# kubectl exec -it -n af-user-jobs $OBJ_NAME -- /usr/src/app/entrypoint.sh bash -c "cd projects/hpi && dbt run -m source:hpi_sources+"
