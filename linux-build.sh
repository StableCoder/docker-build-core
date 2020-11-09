#!/usr/bin/bash
set -e

cd $OS
cp ../entrypoint.sh .

for FILE in *.Dockerfile; do
    docker buildx build --pull ${EXTRA_BUILD_OPTIONS} --platform ${PLATFORMS} -t test:${FILE%.*} -f ${FILE} .
done
