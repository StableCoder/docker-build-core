#!/bin/sh

if [ "${RELEASE}" == "" ]; then
    RELEASE=latest
fi

sed -i '1s/.*/FROM ${OS}:${RELEASE}/' ${OS}/${OS}${RELEASE}/gcc.dockerfile
sed -i '1s/.*/FROM ${OS}:${RELEASE}/' ${OS}/${OS}${RELEASE}/clang.dockerfile