#!/bin/sh

if [ "${VERSION}" == "" ]; then
    VERSION=latest
fi

sed -i '1s/.*/FROM ${OS}:${VERSION}/' ${OS}/${OS}${RELEASE}/gcc.dockerfile
sed -i '1s/.*/FROM ${OS}:${VERSION}/' ${OS}/${OS}${RELEASE}/clang.dockerfile