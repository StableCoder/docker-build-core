#!/bin/sh

MAIN_TAG=""
OS=""
FIRST_SEP=':'
RELEASE=""
SECOND_SEP='-'
POST_TAG=""
BUILD=false
FIRST_RUN=true
NO_CACHE=false
PUSH_IMAGES=false

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
    echo "  -f  First separator in the tag (default ':')"
    echo "  -r  Release of the OS"
    echo "  -s  Second separator in the tag (default '-')"
    echo "  -p  The postfix to add to the tag."
    echo "  -u  Push the build images."

    exit
}

while getopts 'bnt:o:f:r:s:p:u' flag; do
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
        f)
            FIRST_SEP="${OPTARG}"
            ;;
        r)
            RELEASE="${OPTARG}"
            ;;
        s)
            SECOND_SEP="${OPTARG}"
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

cd ${OS}/${OS}${RELEASE}

# Set TAG to 'latest' if no RELEASE was provided
if [ "${RELEASE}" == "" ]; then
    TAG=latest
else
    TAG=${RELEASE}
fi

echo "Images for ${OS} ${RELEASE}"

for i in `find . -name '*.dockerfile'` ; do
    filename=$(basename ${i} .dockerfile)

    original=$(head -n 1 ${filename}.dockerfile)
    sed -i "1s/.*/FROM $OS:$TAG/" ${filename}.dockerfile

    echo "docker build --pull -t ${MAIN_TAG}${FIRST_SEP}${OS}${SECOND_SEP}${filename}${POST_TAG} -f ${filename}.dockerfile ."
    if [ "${BUILD}" = true ] ; then
        if [ "${FIRST_RUN}" = true ] && [ "${NO_CACHE}" = true] ; then
            docker build --no-cache --pull -t ${MAIN_TAG}${FIRST_SEP}${OS}${SECOND_SEP}${filename}${POST_TAG} -f ${filename}.dockerfile .
        else
            docker build --pull -t ${MAIN_TAG}${FIRST_SEP}${OS}${SECOND_SEP}${filename}${POST_TAG} -f ${filename}.dockerfile .
        fi
    fi

    sed -i "1s/.*/${original}/" ${filename}.dockerfile
done

if [ "${PUSH_IMAGES}" = true ] ; then
    for i in `find . -name '*.dockerfile'` ; do
        filename=$(basename ${i} .dockerfile)
        echo "docker push ${MAIN_TAG}${FIRST_SEP}${OS}${SECOND_SEP}${filename}${POST_TAG}"
        docker push ${MAIN_TAG}${FIRST_SEP}${OS}${SECOND_SEP}${filename}${POST_TAG}
    done
fi