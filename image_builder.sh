#!/bin/sh

IMAGE_NAME=""
OS=""
SUFFIX=""
BUILD=false
FIRST_RUN=true
NO_CACHE=false
PUSH_IMAGES=false
TEST_IMAGES=false

set -e
set -o pipefail

usage() {
    cat << USAGE >&2
Used to build and push images from within the repository dynamically.

Usage:
  ./image_builder.sh [OPTIONS] -i <image-name> -o <OS>

  -b, --build                     Builds the images
  -n, --no-cache                  Builds the series starting with a --no-cache,
                                  allowing for a fresh image build.
  -i <name>, --image=<name>       The main image name.
  -o <os>, --os=<os>              Name of the OS building for.
  -s <suffix>, --suffix=<suffix>  The suffix to add to the tag.
  -p, --push                      Push the build images.
  -t, --test                      Test the built image to ensure is starts up
                                  and exits correctly.
USAGE
    exit 1
}

while [[ $# -gt 0 ]]
do
    case "$1" in
        -b | --build)
            BUILD=true
            shift 1
            ;;
        -n | --no-cache)
            NO_CACHE=true
            shift 1
            ;;
        -i)
            IMAGE_NAME="$2"
            if [[ $IMAGE_NAME == "" ]]; then break; fi
            shift 2
            ;;
        --image=*)
            IMAGE_NAME="${1#*=}"
            shift 1
            ;;
        -o)
            OS="$2"
            if [[ $OS == "" ]]; then break; fi
            shift 2
            ;;
        --os=*)
            OS="${1#*=}"
            shift 1
            ;;
        -s)
            SUFFIX="$2"
            if [[ $SUFFIX == "" ]]; then break; fi
            shift 2
            ;;
        --suffix=*)
            SUFFIX="${1#*=}"
            shift 1
            ;;
        -p | --push)
            PUSH_IMAGES=true
            shift 1
            ;;
        -t | --test)
            TEST_IMAGES=true
            shift 1
            ;;
        -h | --help)
            usage
            ;;
        *)
            printf "Unknown argument: $1\n"
            usage
            ;;
    esac
done

if [ "${IMAGE_NAME}" = "" ] || [ "${OS}" = "" ] ; then
    usage
fi

cd ${OS}

for dir in `echo */` ; do
    dir=${dir%%\/*} # Remove the following '/' for the directory

    cd $dir 
        printf "\nImages of the ${OS}/${dir} directory\n\n"

        # Determine the source image name
        source=${OS}

        temp=${dir%%-*}
        temp=${temp#*${OS}}
        if [ "${temp}" != "" ] ; then
            source=${source}/${temp}
        fi

        if [ -z "${dir##*-*}" ] ; then
            source=${source}:${dir#*-}
        else
            source=${source}:latest
        fi

        COUNTER=0
        FIRST_RUN=true
        while [ "$COUNTER" != "3" ] ; do
            # Build

            ## Change FROM image to the one named by the directory
            original=$(head -n 1 Dockerfile)
            sed -i "1s#.*#FROM ${source}#" Dockerfile

            ## Change the entrypoint to a specific one
            if [ "$COUNTER" == "0" ] ; then
                VARIANT_TAG=

            elif [ "$COUNTER" == "1" ] && grep -Fq "# GCC" Dockerfile ; then
                VARIANT_TAG=-gcc
                sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-g", "--"  ]/' Dockerfile

            elif [ "$COUNTER" == "2" ] && grep -Fq "# Clang" Dockerfile ; then
                VARIANT_TAG=-clang
                sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-c", "--"  ]/' Dockerfile

            else
                COUNTER=$((COUNTER + 1))
                continue
            fi

            printf "\n!! Source image: %s !!\n" $source
            if [ "${BUILD}" = true ] ; then
                if [ "${FIRST_RUN}" = true ] && [ "${NO_CACHE}" = true ] ; then
                    printf "docker build --pull --no-cache -t %s:%s%s%s .\n\n" $IMAGE_NAME ${OS} $VARIANT_TAG $SUFFIX
                    docker build --no-cache --pull -t ${IMAGE_NAME}:${OS}${VARIANT_TAG}${SUFFIX} .
                    FIRST_RUN=false
                else
                    printf "docker build --pull -t %s:%s%s%s .\n\n" $IMAGE_NAME ${OS} $VARIANT_TAG $SUFFIX
                    docker build --pull -t ${IMAGE_NAME}:${OS}${VARIANT_TAG}${SUFFIX} .
                fi
            fi

            if [ "$TEST_IMAGES" = true ] ; then
                printf "\n!! Testing the image !!\n"
                docker run --rm ${IMAGE_NAME}:${OS}${VARIANT_TAG}${SUFFIX} conan --version
                printf "!! Image testing complete!!\n"
            fi

            ## Set Entrypoint back
            sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ "" ]/' Dockerfile
            ## Set FROM back to original
            sed -i "1s#.*#${original}#" Dockerfile

            # Push
            if [ "${PUSH_IMAGES}" = true ] ; then
                printf "\n!! Pushing image to registry !!\n"
                printf "docker push %s:%s%s%s .\n\n" $IMAGE_NAME ${OS} $VARIANT_TAG $SUFFIX
                docker push ${IMAGE_NAME}:${OS}${VARIANT_TAG}${SUFFIX}
            fi

            # Increment the counter for the next variant
            COUNTER=$((COUNTER + 1))
        done

    cd ..
done