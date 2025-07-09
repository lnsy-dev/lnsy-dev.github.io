#!/bin/bash

# This script uses ImageMagick to change the background color of your favicons.
# Make sure you have ImageMagick installed: https://imagemagick.org/script/download.php

# --- Configuration ---
# The new background color
NEW_COLOR="#0f172a"

# The old background color to be replaced.
OLD_COLOR="#224411"

# Fuzz factor helps match shades of the old color.
# Start with 20% and adjust if needed.
FUZZ_FACTOR="20%"

# --- Files to Process ---
FILES=(
  "android-chrome-192x192.png"
  "android-chrome-512x512.png"
  "apple-touch-icon.png"
  "favicon-16x16.png"
  "favicon-32x32.png"
  "favicon.ico"
)

# --- Main Script ---
echo "Starting favicon background replacement..."

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "Processing $file..."

    # Create a backup of the original file
    cp "$file" "${file}.bak"

    # Use ImageMagick's `magick` command to replace the color.
    # This command reads the file, replaces the old color with the new color,
    # and overwrites the original file.
    magick "$file" -fuzz "$FUZZ_FACTOR" -fill "$NEW_COLOR" -opaque "$OLD_COLOR" "$file"

    echo " -> Done. Backup created at ${file}.bak"
  else
    echo " -> Warning: File '$file' not found. Skipping."
  fi
done

echo "Script finished."
