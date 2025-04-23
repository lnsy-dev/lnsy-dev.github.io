#!/bin/bash

# Script to posterize JPG files in the images directory using colors from variables.css
# Uses ImageMagick's convert command

echo "Starting image posterization with CSS colors..."

# Directory containing the images
IMAGE_DIR="./images"
CSS_FILE="./assets/variables.css"

# Check if the directory exists
if [ ! -d "$IMAGE_DIR" ]; then
    echo "Error: Directory $IMAGE_DIR does not exist."
    exit 1
fi

# Check if the CSS file exists
if [ ! -f "$CSS_FILE" ]; then
    echo "Error: CSS file $CSS_FILE does not exist."
    exit 1
fi

# Extract colors from variables.css
echo "Extracting colors from $CSS_FILE..."
# Background colors
BACKGROUND_PRIMARY=$(grep -o "\--background-primary: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
BACKGROUND_SECONDARY=$(grep -o "\--background-secondary: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
BACKGROUND_PRIMARY_ALT=$(grep -o "\--background-primary-alt: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
BACKGROUND_SECONDARY_ALT=$(grep -o "\--background-secondary-alt: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
BACKGROUND_MODIFIER_HOVER=$(grep -o "\--background-modifier-hover: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
BACKGROUND_MODIFIER_ACTIVE=$(grep -o "\--background-modifier-active: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)

# Text colors
TEXT_NORMAL=$(grep -o "\--text-normal: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
H1_COLOR=$(grep -o "\--h1-color: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
BOLD_COLOR=$(grep -o "\--bold-color: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
CODE_NORMAL=$(grep -o "\--code-normal: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
CODE_COMMENT=$(grep -o "\--code-comment: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
TEXT_MUTED=$(grep -o "\--text-muted: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)
LIST_MARKER_COLOR=$(grep -o "\--list-marker-color: #[0-9a-fA-F]\+" "$CSS_FILE" | cut -d '#' -f 2)

# Print the extracted colors for verification
echo "Extracted colors:"
echo "Background Primary: #$BACKGROUND_PRIMARY"
echo "Text Normal: #$TEXT_NORMAL"
echo "H1 Color: #$H1_COLOR"
echo "Bold Color: #$BOLD_COLOR"
echo "Code Normal: #$CODE_NORMAL"
echo "Code Comment: #$CODE_COMMENT"
echo "Text Muted: #$TEXT_MUTED"

# Create a temporary color palette image
PALETTE_IMG="/tmp/css_palette.png"

# Create a palette image with all our extracted colors - only if colors were successfully extracted
if [ -n "$BACKGROUND_PRIMARY" ] && [ -n "$TEXT_NORMAL" ]; then
    echo "Creating color palette..."
    convert -size 1x7 \
        xc:"#$BACKGROUND_PRIMARY" \
        xc:"#$TEXT_NORMAL" \
        xc:"#$H1_COLOR" \
        xc:"#$BOLD_COLOR" \
        xc:"#$CODE_NORMAL" \
        xc:"#$CODE_COMMENT" \
        xc:"#$TEXT_MUTED" \
        +append "$PALETTE_IMG"
    
    echo "Created color palette with CSS theme colors"
else
    echo "Error: Could not extract colors from CSS file."
    exit 1
fi

# Count JPG files
JPG_COUNT=$(find "$IMAGE_DIR" -name "*.jpg" -not -name "*_posterized.jpg" -not -name "*_limited.jpg" | wc -l)
echo "Found $JPG_COUNT JPG files to process."

# Process all JPG files
for IMG_FILE in "$IMAGE_DIR"/*.jpg; do
    if [ -f "$IMG_FILE" ]; then
        FILENAME=$(basename -- "$IMG_FILE")
        BASENAME="${FILENAME%.*}"
        
        # Skip files that already have "_posterized" or "_limited" suffix
        if [[ "$BASENAME" == *"_posterized" || "$BASENAME" == *"_limited" ]]; then
            echo "Skipping already processed file: $FILENAME"
            continue
        fi
        
        OUTPUT_FILE="$IMAGE_DIR/${BASENAME}_posterized.jpg"
        
        echo "Posterizing $FILENAME with CSS theme colors..."
        
        # Apply posterization using our CSS colors
        convert "$IMG_FILE" \
            -background "#$BACKGROUND_PRIMARY" \
            -alpha remove \
            -alpha off \
            -dither None \
            -colors 7 \
            -map "$PALETTE_IMG" \
            "$OUTPUT_FILE"
        
        # Verify conversion was successful
        if [ -f "$OUTPUT_FILE" ]; then
            echo "Successfully posterized $FILENAME to ${BASENAME}_posterized.jpg"
        else
            echo "Failed to posterize $FILENAME"
        fi
    fi
done

# Clean up
if [ -f "$PALETTE_IMG" ]; then
    rm "$PALETTE_IMG"
fi

echo "Posterization complete!" 