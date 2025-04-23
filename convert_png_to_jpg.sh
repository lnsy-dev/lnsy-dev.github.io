#!/bin/bash

# Script to convert all PNG files in the images directory to JPG format
# Uses ImageMagick's convert command
# Restricts colors to those specified in variables.css

echo "Starting image conversion with strict color palette..."

# Directory containing the images
IMAGE_DIR="./images"

# Check if the directory exists
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Error: Directory $IMAGE_DIR does not exist."
    exit 1
fi

# Colors from variables.css
BACKGROUND_PRIMARY="#fcf9f0"
TEXT_NORMAL="#0a5c0a"
H1_COLOR="#064d06"
H2_COLOR="#064d06"
H3_COLOR="#064d06"
H4_COLOR="#064d06"
H5_COLOR="#064d06"
H6_COLOR="#064d06"
BOLD_COLOR="#054b05"
CODE_NORMAL="#0a5c0a"
CODE_COMMENT="#639e71"
CODE_BACKGROUND="#f5f2e8"

# Create a temporary color palette image
PALETTE_IMG="/tmp/palette.png"

# Create a palette image with just our colors
convert -size 1x7 xc:"$BACKGROUND_PRIMARY" xc:"$TEXT_NORMAL" xc:"$H1_COLOR" \
        xc:"$BOLD_COLOR" xc:"$CODE_NORMAL" xc:"$CODE_COMMENT" xc:"$CODE_BACKGROUND" \
        +append "$PALETTE_IMG"

echo "Created color palette with theme colors"

# Count PNG files
PNG_COUNT=$(find "$IMAGE_DIR" -name "*.png" | wc -l)
echo "Found $PNG_COUNT PNG files to convert."

# Also process existing JPG files
JPG_COUNT=$(find "$IMAGE_DIR" -name "*.jpg" -not -name "*_limited.jpg" | wc -l)
echo "Found $JPG_COUNT JPG files to process."

# Process all image files (PNG and JPG)
for IMG_FILE in "$IMAGE_DIR"/*.{png,jpg}; do
    if [ -f "$IMG_FILE" ]; then
        FILENAME=$(basename -- "$IMG_FILE")
        EXTENSION="${FILENAME##*.}"
        BASENAME="${FILENAME%.*}"
        
        # Skip files that already have "_limited" suffix
        if [[ "$BASENAME" == *"_limited" ]]; then
            echo "Skipping already processed file: $FILENAME"
            continue
        fi
        
        OUTPUT_FILE="$IMAGE_DIR/${BASENAME}_limited.jpg"
        
        echo "Processing $FILENAME to strictly limit colors..."
        
        # First set background and then limit to our color map
        convert "$IMG_FILE" \
            -background "$BACKGROUND_PRIMARY" \
            -alpha remove \
            -alpha off \
            -colors 7 \
            -dither None \
            -map "$PALETTE_IMG" \
            "$OUTPUT_FILE"
        
        # Verify conversion was successful
        if [ -f "$OUTPUT_FILE" ]; then
            echo "Successfully processed $FILENAME to ${BASENAME}_limited.jpg"
            
            # Delete the original PNG file if it was a PNG
            if [ "$EXTENSION" = "png" ]; then
                rm "$IMG_FILE"
                echo "Deleted original PNG file: $FILENAME"
            fi
        else
            echo "Failed to process $FILENAME"
        fi
    fi
done

# Clean up
rm "$PALETTE_IMG"

echo "Processing complete!" 