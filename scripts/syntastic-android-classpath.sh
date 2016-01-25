#!/bin/bash

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

BASE_PATH=$(getbasepath)
if [ -z "$BASE_PATH" ]; then
    exit
fi

LIBRARIES=$(sed '/\\$/ {:a; N; s/\\\n[\w]*/ /; t a}' $(find . -name Android.mk) | grep 'LOCAL_\(STATIC_\)\?JAVA_LIBRARIES' | cut -d= -f2 | sed -e 's/^ *//' -e 's/ *$//' -e 's/ \+/ /g')
LIBRARIES="core core-junit core-libart ext framework $LIBRARIES"
LIBRARIES=$(echo $LIBRARIES | tr ' ' '\n' | sort -u | grep -v '^\\$')

for line in $LIBRARIES; do
    echo $BASE_PATH/out/target/common/obj/JAVA_LIBRARIES/${line}_intermediates/classes.jar
done

# Resources
echo $BASE_PATH/out/target/common/R

# Locally available source files
timeout 2s find . -type d -name java -o -name src
