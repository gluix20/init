#!/bin/bash
#v2024-07-21
[ -f "load_env.sh" ] && source load_env.sh || source ../load_env.sh

TEMPLATE=$1

IMAGE_NAME=$(basename "$BUILD_BASE_IMAGE_URI")
OBJ_NAME="${IMAGE_NAME/-image/-test}"
OBJ_NAME="${OBJ_NAME/./-}"
export OBJ_NAME

REPO_TAG=$(cat TAG)
IMAGE_URI=${BUILD_BASE_IMAGE_URI//"__PROJECT__"/"ids-sf-services-prod"}:$REPO_TAG
export IMAGE_URI

export RUN_ENV
export KUBE_SA

# Use command substitution to capture the output of envsubst
substituted_template=$(envsubst < ./kube/templates/${TEMPLATE})

# Try to apply the configuration using the substituted template
if ! echo "$substituted_template" | kubectl apply -f - 2>/dev/null; then
  echo "Apply failed, attempting to delete and re-apply..."
  echo "$substituted_template" | kubectl delete -f -
  echo "$substituted_template" | kubectl apply -f -
fi

# To access from terminal use:
# kubectl exec -it -n $KUBE_NAMESPACE $OBJ_NAME -- /bin/bash
