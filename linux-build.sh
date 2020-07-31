#!/usr/bin/bash

cd $OS
cp ../entrypoint.sh .

for FILE in *.Dockerfile; do
    docker buildx build --builder job_${CI_JOB_ID} --pull ${EXTRA_BUILD_OPTIONS} --platform ${PLATFORMS} -t test:${FILE%.*} -f ${FILE} .
done