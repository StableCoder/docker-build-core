#!/bin/sh

TAG=${RELEASE}

if [ "${RELEASE}" == "" ]; then
    TAG=latest
fi

sed -i "1s/.*/FROM $OS:$TAG/" ${OS}/${OS}${RELEASE}/gcc.dockerfile
sed -i "1s/.*/FROM $OS:$TAG/" ${OS}/${OS}${RELEASE}/clang.dockerfile