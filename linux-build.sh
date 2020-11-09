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

cd $OS
cp ../entrypoint.sh .

for FILE in *.Dockerfile; do
    docker buildx build --pull ${PUSH} ${EXTRA_BUILD_OPTIONS} --platform ${PLATFORMS} -t ${TAG}:${FILE%.*} -f ${FILE} .
done
