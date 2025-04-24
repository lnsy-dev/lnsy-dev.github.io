#!/bin/bash

# Create tags directory if it doesn't exist
mkdir -p _tags

# Extract all hashtags from posts
echo "Extracting hashtags from posts..."
# Using Extended regex with grep -E
HASHTAGS=$(grep -Eoh "#[a-zA-Z0-9-]+" _posts/*.md | sed 's/#//' | sort | uniq)

# Extract tags from YAML front matter
echo "Extracting tags from YAML front matter..."
# This handles the indented YAML tag format
YAML_TAGS=$(awk '/^---/{flag=1;next}/^---/{flag=0}flag && /^ *- [a-zA-Z0-9-]+/{gsub(/^ *- /,"");print}' _posts/*.md | sort | uniq)

# Combine both sets of tags
ALL_TAGS=$(echo "$HASHTAGS"$'\n'"$YAML_TAGS" | grep -v "^$" | sort | uniq)

# Create tag pages
for tag in $ALL_TAGS; do
  echo "Creating tag page for: $tag"
  if [ ! -f "_tags/$tag.md" ]; then
    echo "---" > "_tags/$tag.md"
    echo "layout: tag" >> "_tags/$tag.md"
    echo "title: $tag" >> "_tags/$tag.md"
    echo "---" >> "_tags/$tag.md"
  fi
done

echo "Done! Created tag pages for all hashtags and YAML tags in posts." 