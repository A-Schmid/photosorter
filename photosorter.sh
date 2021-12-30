#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2

# recursively find all CR2 Canon raw files in INPUT_DIR
# (this should also work with other image formats)
find $INPUT_DIR -name \*.CR2 | while read file; do

    # check if the file exists
    if test -f "$file";
    then
        # extract filename from path
        FILENAME=$(echo $file | grep -o '[^/]*$')

        # extract capturing date from exif metadata
        DATE=$(mediainfo --language=raw --Inform="Image;%Encoded_Date%" $file | awk -F' ' '{print $1}' | tr ':' '-')

        # create output directory for the current date if it does not exist yet
        if [ ! -d "$OUTPUT_DIR/$DATE" ]; then
            mkdir "$OUTPUT_DIR/$DATE"
        fi

        # skip if file already exists
        if test -f "$OUTPUT_DIR/$DATE/$FILENAME"
        then
            echo "skip $file"
            continue
        fi

        # copy file
        cp $file "$OUTPUT_DIR/$DATE/"

        # use this line to create a symlink instead of copying
        #ln -sr $file "$OUTPUT_DIR/$DATE/"

        echo "create $file -> $OUTPUT_DIR/$DATE/$FILENAME"

        # if there is an XMP sidecar file, also copy it
        if test -f "$file.xmp";
        then
            cp "$file.xmp" "$OUTPUT_DIR/$DATE/"
            echo "create $file.xmp -> $OUTPUT_DIR/$DATE/$FILENAME"
        fi
    fi
done
