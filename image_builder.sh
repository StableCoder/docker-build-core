#!/bin/sh

IMAGE_NAME=""
OS=""
SUFFIX=""
BUILD=false
BUILDX=
PLATFORM=
FIRST_RUN=true
NO_CACHE=false
PUSH_IMAGES=false
TEST_IMAGES=false
POST_RM=false
IMAGE_LIST=""

set -e
set -o pipefail

usage() {
    cat <<USAGE >&2
Used to build and push images from within the repository dynamically.

Usage:
  ./image_builder.sh [OPTIONS] -i <image-name> -o <OS>

  -b, --build                     Builds the images
      --buildx                    Builds using 'buildx' instead
  -n, --no-cache                  Builds the series starting with a --no-cache,
                                  allowing for a fresh image build.
  -i <name>, --image=<name>       The main image name.
  -o <os>, --os=<os>              Name of the OS building for.
  -s <suffix>, --suffix=<suffix>  The suffix to add to the tag.
  -p, --push                      Push the build images.
  -t, --test                      Test the built image to ensure is starts up
                                  and exits correctly.
  -r, --rm                        Untag/remove images after (for test images).
USAGE
    exit 1
}

while [[ $# -gt 0 ]]; do
    case "$1" in
    -b | --build)
        BUILD=true
        shift 1
        ;;
    --buildx)
        BUILDX="buildx"
        shift
        ;;
    --builder)
        BUILDER="--load --builder $2"
        shift 2
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
    --platform)
        if [ "$PLATFORM" == "" ]; then
            PLATFORM="--platform $2"
        else
            PLATFORM="$PLATFORM,$2"
        fi
        shift 2
        ;;
    -p | --push)
        PUSH_IMAGES=true
        shift 1
        ;;
    -t | --test)
        TEST_IMAGES=true
        shift 1
        ;;
    -r | --rm)
        POST_RM=true
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

if [ "${IMAGE_NAME}" = "" ] || [ "${OS}" = "" ]; then
    usage
fi

for dir in $(echo ${OS}/*/); do
    dir=${dir#*\/}
    dir=${dir%%\/*} # Remove the following '/' for the directory

    printf "\n\n\n >>>> Images of the ${OS}/${dir} directory\n"

    # Determine the source image name
    source=${OS}

    temp=${dir%%-*}
    temp=${temp#*${OS}}
    if [ "${temp}" != "" ]; then
        source=${source}/${temp}
    fi

    if [ -z "${dir##*-*}" ]; then
        source=${source}:${dir#*-}
        OS_VER=${dir#*-}
    else
        source=${source}:latest
        OS_VER=
    fi

    COUNTER=0
    FIRST_RUN=true
    while [ "$COUNTER" != "3" ]; do

        ## Change FROM image to the one named by the directory
        original=$(head -n 1 $OS/$dir/Dockerfile)
        sed -i "1s#.*#FROM ${source}#" $OS/$dir/Dockerfile

        ## Change the entrypoint to a specific one
        if [ "$COUNTER" == "0" ]; then
            VARIANT_TAG=

        elif [ "$COUNTER" == "1" ] && grep -Fq "gcc" $OS/$dir/Dockerfile; then
            VARIANT_TAG=-gcc
            sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-g", "--" ]/' $OS/$dir/Dockerfile

        elif [ "$COUNTER" == "2" ] && grep -Fq "clang" $OS/$dir/Dockerfile; then
            VARIANT_TAG=-clang
            sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-c", "--" ]/' $OS/$dir/Dockerfile

        else
            COUNTER=$((COUNTER + 1))
            continue
        fi

        printf "\n >> Source image: %s\n" $source
        if [ "${BUILD}" = true ]; then
            if [ "${FIRST_RUN}" = true ] && [ "${NO_CACHE}" = true ] && [ "${OS_VER}" != "" ]; then
                echo docker $BUILDX build $BUILDER --no-cache --pull $PLATFORM -t ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX} -f $OS/$dir/Dockerfile .
                docker $BUILDX build $BUILDER --no-cache --pull $PLATFORM -t ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX} -f $OS/$dir/Dockerfile .
                FIRST_RUN=false
            else
                echo docker $BUILDX build $BUILDER --pull $PLATFORM -t ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX} -f $OS/$dir/Dockerfile .
                docker $BUILDX build $BUILDER --pull $PLATFORM -t ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX} -f $OS/$dir/Dockerfile .
            fi
        fi

        if [ "$TEST_IMAGES" = true ]; then
            printf "\n >> Testing the image\n"
            echo docker run --rm ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX}
            docker run --rm ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX}
            printf " >> Image testing complete\n"
        fi

        ## Set Entrypoint back
        sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ "\/entrypoint.sh", "-v", "--" ]/' $OS/$dir/Dockerfile
        ## Set FROM back to original
        sed -i "1s#.*#${original}#" $OS/$dir/Dockerfile

        IMAGE_LIST="${IMAGE_LIST} ${IMAGE_NAME}:${OS}${OS_VER}${VARIANT_TAG}${SUFFIX}"

        # Increment the counter for the next variant
        COUNTER=$((COUNTER + 1))
    done

done

# Push
if [ "${PUSH_IMAGES}" = true ]; then
    for IMAGE in $IMAGE_LIST; do

        printf "\n >> Pushing image to registry: $IMAGE \n"
        echo docker push $IMAGE
        docker push $IMAGE

    done
fi

# Image Removal
if [ "${POST_RM}" = true ]; then
    for IMAGE in $IMAGE_LIST; do
        printf "\n >> Removing the image: $IMAGE\n"
        docker rmi $IMAGE
    done
fi
