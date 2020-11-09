#!/usr/bin/bash
set -e

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    --tag)
        TAG="$2"
        shift # past argument
        shift # past value
        ;;
    --push)
        PUSH="--push"
        shift # past argument
        ;;
    esac
done

for FILE in ${OS}/*.Dockerfile; do
    FILE="$(basename -- $FILE)"
    docker buildx build --pull ${PUSH} ${EXTRA_BUILD_OPTIONS} --platform ${PLATFORMS} -t ${TAG}:${FILE%.*} -f ${OS}/${FILE} .
done
