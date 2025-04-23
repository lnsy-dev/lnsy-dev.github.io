#!/bin/bash

# Create tags directory if it doesn't exist
mkdir -p _tags

# Extract all hashtags from posts
echo "Extracting hashtags from posts..."
TAGS=$(grep -oh "#\w\+" _posts/*.md | sed 's/#//' | sort | uniq)

# Create tag pages
for tag in $TAGS; do
  echo "Creating tag page for: $tag"
  if [ ! -f "_tags/$tag.md" ]; then
    echo "---" > "_tags/$tag.md"
    echo "layout: tag" >> "_tags/$tag.md"
    echo "title: $tag" >> "_tags/$tag.md"
    echo "---" >> "_tags/$tag.md"
  fi
done

echo "Done! Created tag pages for all hashtags in posts." 