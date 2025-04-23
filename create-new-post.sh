#!/bin/bash

# Exit if any command fails
set -e

# Check if a post name was provided
if [ $# -eq 0 ]; then
  echo "Error: No post name provided."
  echo "Usage: ./create-new-post.sh my-new-post-name"
  exit 1
fi

# Get the post name from the command line argument
POST_NAME=$1

# Format the date for the filename (YYYY-MM-DD)
DATE=$(date +"%Y-%m-%d")

# Format the datetime for the frontmatter (YYYY-MM-DD HH:MM:SS +/-TTTT)
DATETIME=$(date +"%Y-%m-%d %H:%M:%S %z")

# Create the filename
FILENAME="_posts/${DATE}-${POST_NAME}.md"

# Make sure _posts directory exists
mkdir -p _posts

# Check if the file already exists
if [ -f "$FILENAME" ]; then
  echo "Error: Post $FILENAME already exists."
  exit 1
fi

# Create the post file with frontmatter
cat > "$FILENAME" << EOF
---
layout: post
title: "$(echo $POST_NAME | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)} 1')"
date: $DATETIME
categories: blog
---

Write your post content here. This is a new post created on $DATE.

## Heading

* Bullet point
* Another bullet point

1. Numbered list
2. Second item

\`\`\`
// Code block
\`\`\`

[Link text](https://example.com)

![Image alt text](/path/to/image.jpg)
EOF

echo "Created new post: $FILENAME"
echo "You can now edit this post with your favorite editor." 