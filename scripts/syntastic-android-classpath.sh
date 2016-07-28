#!/bin/bash

function timeout() {
    perl -e 'alarm shift; exec @ARGV' "$@"
}

getproj () {
    # This funciton is based on cproj()
    local TOPFILE=build/core/envsetup.mk
    local HERE=$PWD
    local T=
    while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
        T=$PWD
        if [ -f "$T/Android.mk" ]; then
            echo $T
            return
        fi
        cd .. > /dev/null
    done
    return 1
}

getbasepath () {
    # This function is based on gettop()
    local TOPFILE=build/core/envsetup.mk;
    local HERE=$PWD
    local T='.'
    while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
        cd .. > /dev/null
        T="$T/.."
    done;
    cd $HERE > /dev/null;
    if [ ${#T} -gt 2 ]; then
        T=${T:2}
    fi
    if [ -f "$T/$TOPFILE" ]; then
        echo $T
    fi
}

collapseLineContinuation () {
    sed ': again
    /\\$/ {
        N
        s/\\\n//
        t again
    }' "$@"
}

BASE_PATH=$(getbasepath)
PROJECT_PATH=$(cd $(dirname $1) > /dev/null; getproj)
if [ -z "$BASE_PATH" -o -z "$PROJECT_PATH" ]; then
    exit
fi

LIBRARIES=$(collapseLineContinuation $(timeout 2s find $PROJECT_PATH -name Android.mk) | grep 'LOCAL_\(STATIC_\)\?JAVA_LIBRARIES' | cut -d= -f2 | sed -e 's/^ *//' -e 's/ *$//' -e 's/ \+/ /g')
LIBRARIES="core core-junit core-libart ext framework $LIBRARIES"
LIBRARIES=$(echo $LIBRARIES | tr ' ' '\n' | sort -u | grep -v '^\\$')

for line in $LIBRARIES; do
    echo $BASE_PATH/out/target/common/obj/JAVA_LIBRARIES/${line}_intermediates/classes.jar
done

# Resources
echo $BASE_PATH/out/target/common/R

# Locally available source files
timeout 2s find $PROJECT_PATH -type d -name java -o -name src
