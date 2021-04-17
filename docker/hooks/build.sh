#!/usr/bin/env sh

# original docker build command
echo "overwriting docker build -f $DOCKERFILE_PATH -t $IMAGE_NAME ."

jq '.' ../versions.json
