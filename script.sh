#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <directory> <size1> [size2] ..."
    echo "Example: $0 /path/to/directory 512x512 900x600"
    exit 1
fi

if ! command -v convert &> /dev/null
then
    echo "ImageMagick could not be found, installing..."
    sudo apt-get update
    sudo apt-get install imagemagick -y
fi

if ! command -v file &> /dev/null
then
    echo "Command file could not be found, installing..."
    sudo apt-get update
    sudo apt-get install file -y
fi

DIR=$1
shift

# Loop through all images in the directory
for FILE in "$DIR"/*; do
    # Check if the file is an image
    if file "$FILE" | grep -qE 'image|bitmap'; then
        echo $FILE
        # Get image dimensions
        DIMENSIONS=$(identify -format "%wx%h" "$FILE")
        WIDTH=$(echo $DIMENSIONS | cut -dx -f1)
        HEIGHT=$(echo $DIMENSIONS | cut -dx -f2)
        
        # Loop through all given dimensions
        for SIZE in "$@"; do
            TARGET_WIDTH=$(echo $SIZE | cut -dx -f1)
            TARGET_HEIGHT=$(echo $SIZE | cut -dx -f2)
            
            # Check if actual size is greater than the given size
            if [[ "$WIDTH" -gt "$TARGET_WIDTH" ]] || [[ "$HEIGHT" -gt "$TARGET_HEIGHT" ]]; then
                EXT="${FILE##*.}"
                BASENAME=$(basename "$FILE" .$EXT)
                OUTPUT="${DIR}/${BASENAME}-${SIZE}.${EXT}"
                convert "$FILE" -resize "$SIZE" "$OUTPUT"
                echo "Resized $FILE to $SIZE, saved as $OUTPUT"
            else
                echo "Error: $FILE is smaller than or equal to the target size $SIZE. Skipping resize."
            fi
        done
    fi
done
