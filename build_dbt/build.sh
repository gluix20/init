#!/bin/bash
[ -f "load_env.sh" ] && source load_env.sh || source ../load_env.sh

REPO_TAG=t$(TZ="America/New_York" date +%y%m%d.%H%M)

BUILD_BASE_IMAGE_URI=$BUILD_BASE_IMAGE_URI:$REPO_TAG

BUILD_IMAGE_URI_DEV=${BUILD_BASE_IMAGE_URI//"__PROJECT__"/"ids-sf-services-dev"}
BUILD_IMAGE_URI_PPE=${BUILD_BASE_IMAGE_URI//"__PROJECT__"/"ids-sf-services-ppe"}
BUILD_IMAGE_URI_PROD=${BUILD_BASE_IMAGE_URI//"__PROJECT__"/"ids-sf-services-prod"}

SUBSTITUTIONS="_FROM_DBT_IMAGE_URI=$FROM_DBT_IMAGE_URI,\
_BUILD_IMAGE_URI_DEV=$BUILD_IMAGE_URI_DEV,\
_BUILD_IMAGE_URI_PPE=$BUILD_IMAGE_URI_PPE,\
_BUILD_IMAGE_URI_PROD=$BUILD_IMAGE_URI_PROD"

gcloud builds submit --region=$REGION --project ids-sf-services-dev --config cloudbuild_config.yaml . \
  --substitutions=$SUBSTITUTIONS

echo -e "\nArtifact Registry tag: [$REPO_TAG]\n"

echo "$REPO_TAG" > TAG
git tag $REPO_TAG
