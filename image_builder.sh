#!/bin/sh

MAIN_TAG=""
OS=""
POST_TAG=""
BUILD=false
FIRST_RUN=true
NO_CACHE=false
PUSH_IMAGES=false

set -e
set -o pipefail

usage() {
    echo "Used to build and push images from withing the repository dynamically."
    echo ""
    echo "USAGE:"
    echo "  ./image_builder.sh [OPTIONS] -t <tagname> -o <OS>"
    echo ""
    echo "OPTIONS:"
    echo "  -b  Builds the images"
    echo "  -n  Builds the series starting with a --no-cache,"
    echo "      allowing for a fresh image build."
    echo "  -t  The main name of the tag."
    echo "  -o  Name of the OS building for."
    echo "  -p  The postfix to add to the tag."
    echo "  -u  Push the build images."

    exit
}

while getopts 'bnt:o:f:s:p:u' flag; do
    case "${flag}" in
        b)
            BUILD=true
            ;;
        n)
            NO_CACHE=true
            ;;
        t)
            MAIN_TAG="${OPTARG}"
            ;;
        o)
            OS="${OPTARG}"
            ;;
        p)
            POST_TAG="${OPTARG}"
            ;;
        u)
            PUSH_IMAGES=true
            ;;
        *)
           usage
            ;;
    esac
done

if [ "${MAIN_TAG}" = "" ] || [ "${OS}" = "" ] ; then
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
                sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-g" ]/' Dockerfile

            elif [ "$COUNTER" == "2" ] && grep -Fq "# Clang" Dockerfile ; then
                VARIANT_TAG=-clang
                sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-c" ]/' Dockerfile

            elif [ "$COUNTER" == "3" ] && grep -Fq "# Analysis" Dockerfile ; then
                # Analysis capability
                VARIANT_TAG=-analysis
                sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ ".\/entrypoint.sh", "-c" ]/' Dockerfile

            else
                COUNTER=$((COUNTER + 1))
                continue
            fi

            printf "Source image: %s\n\n" $source
            if [ "${BUILD}" = true ] ; then
                if [ "${FIRST_RUN}" = true ] && [ "${NO_CACHE}" = true ] ; then
                    printf "docker build --pull --no-cache -t %s:%s%s%s .\n\n" $MAIN_TAG ${dir//-} $VARIANT_TAG $POST_TAG
                    docker build --no-cache --pull -t ${MAIN_TAG}:${dir//-}${VARIANT_TAG}${POST_TAG} .
                else
                    printf "docker build --pull -t %s:%s%s%s .\n\n" $MAIN_TAG ${dir//-} $VARIANT_TAG $POST_TAG
                    docker build --pull -t ${MAIN_TAG}:${dir//-}${VARIANT_TAG}${POST_TAG} .
                fi
            fi

            ## Set Entrypoint back
            sed -i 's/.*ENTRYPOINT.*/ENTRYPOINT [ "bash" ]/' Dockerfile
            ## Set FROM back to original
            sed -i "1s#.*#${original}#" Dockerfile

            # Push
            if [ "${PUSH_IMAGES}" = true ] ; then
                printf "docker push %s:%s%s%s .\n\n" $MAIN_TAG ${dir//-} $VARIANT_TAG $POST_TAG
                docker push ${MAIN_TAG}:${dir//-}${VARIANT_TAG}${POST_TAG}
            fi

            # Increment the counter for the next variant
            COUNTER=$((COUNTER + 1))
        done

    cd ..
done