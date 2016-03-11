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

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<classpath>'
echo '	<classpathentry exported="true" kind="con" path="com.android.ide.eclipse.adt.LIBRARIES"/>'
echo '	<classpathentry exported="true" kind="con" path="com.android.ide.eclipse.adt.DEPENDENCIES"/>'

function find_wrapper() {
    timeout 2s find . -type d '(' -name .AppleDouble -o -name .git ')' -prune -o "$@" -print
}

ANDROID_MKS=${ANDROID_MKS:-$(find_wrapper -type f -name Android.mk)}
APPS=$(sed '/\\$/ {:a; N; s/\\\n[\w]*/ /; t a}' $ANDROID_MKS | grep 'LOCAL_INSTRUMENTATION_FOR' | cut -d= -f2 | sed -e 's/^ *//' -e 's/ *$//' -e 's/ \+/ /g')
APPS=$(echo $APPS | tr ' ' '\n' | sort -u | grep -v '^\\$')
LIBRARIES=$(sed '/\\$/ {:a; N; s/\\\n[\w]*/ /; t a}' $ANDROID_MKS | grep 'LOCAL_\(STATIC_\)\?JAVA_LIBRARIES' | cut -d= -f2 | sed -e 's/^ *//' -e 's/ *$//' -e 's/ \+/ /g')
LIBRARIES="core-junit core-libart ext framework $LIBRARIES"
LIBRARIES=$(echo $LIBRARIES | tr ' ' '\n' | sort -u | grep -v '^\\$')

for line in $APPS; do
    JAR=out/target/common/obj/APPS/${line}_intermediates/classes.jar
    echo '	<classpathentry kind="lib" path="'${BASE_PATH}/${JAR}'"/>'
done

for line in $LIBRARIES; do
    JAR=out/target/common/obj/JAVA_LIBRARIES/${line}_intermediates/classes.jar
    echo '	<classpathentry kind="lib" path="'${BASE_PATH}/${JAR}'"/>'
done

# We don't actually want this, but ADT will re-add it, so we put it after the core libs to cause
# eclipse to ignore the classes in ANDROID_FRAMEWORK
echo '	<classpathentry kind="con" path="com.android.ide.eclipse.adt.ANDROID_FRAMEWORK"/>'

# Resources
#echo '	<classpathentry kind="src" path="R"/>'

# Locally available source files
find_wrapper -type d -name java -o -name src | while read line; do
    line=${line#./}
    echo '	<classpathentry kind="src" path="'$line'"/>'
done

echo '	<classpathentry kind="src" path="gen">'
echo '		<attributes>'
echo '			<attribute name="ignore_optional_problems" value="true"/>'
echo '		</attributes>'
echo '	</classpathentry>'


find_wrapper -type f -name *.jar | while read line; do
    line=${line#./}
    echo '	<classpathentry kind="lib" path="'$line'"/>'
done

echo '	<classpathentry kind="output" path="bin/classes"/>'
echo '</classpath>'
