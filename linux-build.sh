#!/usr/bin/bash
set -e

TAG=
PUSH=

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -t | --tag)
        TAG="$2"
        shift # past argument
        shift # past value
        ;;
    -p | --push)
        PUSH="--push"
        shift # past argument
        ;;
    esac
done

for FILE in ${OS}/*.Dockerfile; do
    FILE="$(basename -- $FILE)"
    echo "docker buildx build --pull ${PUSH} --platform $(cat ${OS}/${FILE%.*}.cfg) -t ${TAG}:${FILE%.*} -f ${OS}/${FILE} ."
    docker buildx build --pull ${PUSH} --platform $(cat ${OS}/${FILE%.*}.cfg) -t ${TAG}:${FILE%.*} -f ${OS}/${FILE} .
done
