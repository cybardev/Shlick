#!/bin/sh

# DEPENDENCY CHECK
deps="pandoc"
for dep in $deps; do
  command -v "$1" 1>/dev/null || {
    printf "$1 not found. Please install it.\n";
    exit 2;
  }
done

# IMPORTANT CONSTANTS
DIR_LIST="about contact blog"

# FILE CONVERSION
convert() {
  [ -z "$1" ] && FILENAME="index" || FILENAME="$1"
  pandoc "$FILENAME.md" \
      -o "./docs/$FILENAME.html" \
      --standalone \
      --template="./template.html" \
      --css "/assets/style.css" \
      --css "/assets/custom.css" \
      --variable=lastUpdated:$( stat -c %y $FILENAME.md | cut -f 1 -d ' ' ) \
      --variable=creationDate:$( stat -c %w $FILENAME.md | cut -f 1 -d ' ' )
}

main() {
  MY_PATH="$HOME"
  SITE_PATH=$MY_PATH/site

  find $SITE_PATH -name *.md -exec process_md_file {} \;

  exit 0;
}

process_md_file() {
  MY_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  SITE_PATH=$MY_PATH/site

  fullpath=$1
  dirpath=$( dirname $1 )
  sourcefile=$( basename $1 )
  targetfile=$(echo "$sourcefile" | cut -f 1 -d '.')'.html'

  # Use git to get creation and modification date
  lastUpdated=$( git log -1 --format="%ci" -- $fullpath | cut -f 1 -d ' ' )
  creationDate=$( git log --format="%ai" -- $fullpath | tail -1 | cut -f 1 -d ' ' )

  echo Processing: $fullpath

  rm $dirpath/$targetfile
  pandoc $fullpath \
    -o $dirpath/$targetfile \
    --standalone \
    --css "/css/milligram.min.css" \
    --css "/css/custom.css" \
    --template=$MY_PATH/template.html \
    --variable=lastUpdated:$lastUpdated \
    --variable=creationDate:$creationDate ;

  return
}

main
