#!/usr/bin/env bash

# Base directory = the folder where the script is run
BASE_DIR="$(pwd)"

# File extensions lists
PHOTO_EXT="jpg jpeg png gif bmp tiff webp heic heif"
VIDEO_EXT="mp4 mov mkv avi mpeg mpg m4v webm"
PDF_EXT="pdf"

MAX_FILES=500

lower() {
    echo "$1" | tr 'A-Z' 'a-z'
}

# Function: choose correct numbered folder (photos, photos_2...)
choose_folder() {
    local base_dir="$1"
    local type="$2"

    local number=1
    local folder

    while true; do
        if [ "$number" -eq 1 ]; then
            folder="${base_dir}/${type}"
        else
            folder="${base_dir}/${type}_${number}"
        fi

        # Create folder if not exists
        mkdir -p "$folder"

        # Count files
        local count
        count=$(find "$folder" -maxdepth 1 -type f | wc -l)

        # If count < MAX → place here
        if [ "$count" -lt "$MAX_FILES" ]; then
            echo "$folder"
            return
        fi

        number=$((number + 1))
    done
}

# Main file-moving loop
find "$BASE_DIR" -type f | while read -r FILE; do
    [ "$FILE" = "$0" ] && continue   # Skip script itself

    YEAR=$(date -r "$FILE" +"%Y")
    EXT=$(lower "${FILE##*.}")
    TYPE="others"

    # Identify file type
    for e in $PHOTO_EXT; do
        if [ "$EXT" = "$e" ]; then TYPE="photos"; break; fi
    done

    if [ "$TYPE" = "others" ]; then
        for e in $VIDEO_EXT; do
            if [ "$EXT" = "$e" ]; then TYPE="videos"; break; fi
        done
    fi

    if [ "$TYPE" = "others" ] && [ "$EXT" = "pdf" ]; then
        TYPE="pdf"
    fi

    YEAR_DIR="$BASE_DIR/$YEAR"
    mkdir -p "$YEAR_DIR"

    # Photos use auto-split system
    if [ "$TYPE" = "photos" ]; then
        TARGET=$(choose_folder "$YEAR_DIR" "$TYPE")
    else
        TARGET="$YEAR_DIR/$TYPE"
        mkdir -p "$TARGET"
    fi

    mv "$FILE" "$TARGET"/
    echo "Moved: $FILE → $TARGET/"
done

echo "🧹 Cleaning up empty folders..."
find "$BASE_DIR" -type d -empty -delete

echo "✅ Organizing complete!"
echo "🗑️ All empty folders removed."
