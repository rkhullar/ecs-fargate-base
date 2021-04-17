#!/usr/bin/env sh

# original docker build command
echo "overwriting docker build -f $DOCKERFILE_PATH -t $IMAGE_NAME ."

jq -r < ../versions.json 'to_entries | map({runtime: .key, version: .value[]}) | .[] | tostring' | while read jstr
do
  RUNTIME=$(echo $jstr | jq -r '.runtime')
  VERSION=$(echo $jstr | jq -r '.version')
  IMAGE_TAG="${DOCKER_REPO}:${RUNTIME}-${VERSION}-${DOCKER_TAG}"
  echo docker build -t ${IMAGE_TAG} --build-arg RUNTIME=${RUNTIME}--build-arg VERSION=${VERSION} ../
  docker build -t ${IMAGE_TAG} --build-arg RUNTIME=${RUNTIME}--build-arg VERSION=${VERSION} ../
done