#!/bin/sh

# DEPENDENCY CHECK
deps="pandoc"
for dep in $deps; do
    command -v "$1" 1>/dev/null || {
        printf "$1 not found. Please install it.\n";
        exit 2;
    }
done

# FILE CONVERSION
convert() {
    SITE_PATH=$(pwd)

    fullpath=$1
    dirpath=$( dirname $1 )
    sourcefile=$( basename $1 )
    targetfile="$(find '$SITE_PATH/' -name '*.md' -exec sh -c 'basename {} .md' \;).html"

    # Use git to get creation and modification date
    lastUpdated=$( git log -1 --format="%ci" -- $fullpath | cut -f 1 -d ' ' )
    creationDate=$( git log --format="%ai" -- $fullpath | tail -1 | cut -f 1 -d ' ' )

    echo Processing: $fullpath

    rm $dirpath/$targetfile
    pandoc $fullpath \
        -o $dirpath/$targetfile \
        --standalone \
        --css "$SITE_PATH/assets/css/style.css" \
        --css "$SITE_PATH/assets/css/custom.css" \
        --template=$SITE_PATH/template/template.html \
        --variable=lastUpdated:$lastUpdated \
        --variable=creationDate:$creationDate ;

    return
}

# recursively convert all .md files in current directory
main() {
    SITE_PATH=$(pwd)

    find $SITE_PATH -name *.md -exec convert {} \;

    exit 0;
}

main
