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

        # Build
        for i in `find . -name '*.dockerfile'` ; do
            filename=$(basename ${i} .dockerfile)

            original=$(head -n 1 ${filename}.dockerfile)
            sed -i "1s#.*#FROM ${source}#" ${filename}.dockerfile
            
            printf "Source image: %s\n" $source
            echo "docker build --pull -t ${MAIN_TAG}:${dir//-}-${filename}${POST_TAG} -f ${filename}.dockerfile ."
            if [ "${BUILD}" = true ] ; then
                if [ "${FIRST_RUN}" = true ] && [ "${NO_CACHE}" = true ] ; then
                    docker build --no-cache --pull -t ${MAIN_TAG}:${dir//-}-${filename}${POST_TAG} -f ${filename}.dockerfile .
                else
                    docker build --pull -t ${MAIN_TAG}:${dir//-}-${filename}${POST_TAG} -f ${filename}.dockerfile .
                fi
            fi

            sed -i "1s#.*#${original}#" ${filename}.dockerfile
        done

        # Push
        if [ "${PUSH_IMAGES}" = true ] ; then
            for i in `find . -name '*.dockerfile'` ; do
                filename=$(basename ${i} .dockerfile)
                echo "docker push ${MAIN_TAG}:${dir//-}-${filename}${POST_TAG}"
                docker push ${MAIN_TAG}:${dir//-}-${filename}${POST_TAG}
            done
        fi

    cd ..
done