#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOUR='\033[0m'

NO_CACHE=
TAG=
PUSH=
RM=
LAYERS="--layers"

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -n | --no-cache)
        NO_CACHE="--no-cache"
        shift
        ;;
    -o | --os)
        OS="$2"
        shift
        shift
        ;;
    -t | --tag)
        TAG="$2"
        shift # past argument
        shift # past value
        ;;
    -p | --push)
        PUSH="--push"
        shift # past argument
        ;;
    -r | --rm)
        RM=1
        shift
        ;;
    --no-layers)
        LAYERS=
        shift
        ;;
    *)
        printf "${RED}> ERROR${NO_COLOUR} Unknown option '$1'\n" 1>&2
        exit 1
    esac
done

if [[ -z "$OS" ]]; then
    printf "${RED}> ERROR${NO_COLOUR} No OS specified\n" 1>&2
    ERROR=1
fi
if [[ -z "$TAG" ]]; then
    printf "${RED}> ERROR${NO_COLOUR} No TAG specified\n" 1>&2
    ERROR=1
fi
if [[ ! -z $ERROR ]]; then
    exit 1
fi

for FILE in $OS/*.Dockerfile; do
    # Get platforms for the image
    PLATFORMS=$(grep -e '^# PLATFORMS: ' $FILE | head -n 1)
    PLATFORMS=${PLATFORMS:13}

    if [[ -z $PLATFORMS ]]; then
        printf "${RED}> ERROR${NO_COLOUR} No platforms specified for: $FILE\n" 1>&2
        exit 1
    fi

    FILE="$(basename -- $FILE)"

    # Remove any previous manifest
    if podman manifest exists localhost/$TAG:${FILE%.*}; then
        printf "${GREEN}>${NO_COLOUR} Removing manifest: localhost/$TAG:${FILE%.*}\n"
        podman manifest rm localhost/$TAG:${FILE%.*}
    fi

    # Go through each platform and build the image for it, adding to the common manifest tag
    for PLATFORM in $PLATFORMS; do
        if [[ "${FILE%.*}" == *"-"* ]]; then
            printf "${GREEN}>${NO_COLOUR} Running: podman build --pull $LAYERS $NO_CACHE --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .\n"
            BUILDAH_LAYERS=false podman build --pull $LAYERS $NO_CACHE --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .
        else
            if podman image exists localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM); then
                podman rmi localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM)
            fi
            printf "${GREEN}>${NO_COLOUR} Running: podman build --pull $LAYERS --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .\n"
            BUILDAH_LAYERS=false podman build --pull $LAYERS --platform $PLATFORM --file $OS/$FILE --manifest localhost/$TAG:${FILE%.*} --tag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM) .
        fi
    done

    # If selected, push the manifest tag and associated images
    if [ ! -z $PUSH ]; then
        # Using the v2s2 format to 
        printf "${GREEN}>${NO_COLOUR} Running: podman manifest push --all --format v2s2 localhost/${TAG}:${FILE%.*} docker://$TAG:${FILE%.*}\n"
        podman manifest push --all -f v2s2 localhost/$TAG:${FILE%.*} docker://$TAG:${FILE%.*}
    fi

    # Cleanup any manifest
    printf "${GREEN}>${NO_COLOUR} Removing manifest: localhost/$TAG:${FILE%.*}\n"
    podman manifest rm localhost/$TAG:${FILE%.*}
done


if [ ! -z $RM ]; then
    for FILE in $OS/*.Dockerfile; do
        FILE="$(basename -- $FILE)"
        IFS=','
        for PLATFORM in $(cat $OS/${FILE%.*}.cfg); do
           if podman untag localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM); then
                echo "> Untagged image: localhost/$TAG:${FILE%.*}-$(cut -d '/' -f2 <<<$PLATFORM)"
           fi
        done
    done
fi