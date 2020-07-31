#!/usr/bin/bash

cd $OS
cp ../entrypoint.sh .

for FILE in *.Dockerfile; do
    docker buildx build --builder job_${CI_JOB_ID} --push --pull ${EXTRA_BUILD_OPTIONS} --platform ${PLATFORMS} -t ${DOCKER_REGISTRY}${CORE_NAME}:${FILE%.*} -f ${FILE} . || echo
    docker buildx build --builder job_${CI_JOB_ID} --push ${EXTRA_BUILD_OPTIONS} --platform ${PLATFORMS} -t ${DOCKER_REGISTRY}${CORE_NAME}:${FILE%.*} -f ${FILE} .
done