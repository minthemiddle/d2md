#!/bin/bash

output_folder="${nota:-output}/_Posteingang"

# Create the output folder if it doesn't exist
mkdir -p "$output_folder"

# Get the Markdown content from the clipboard
content=$(pbpaste)

# Remove leading and trailing whitespaces
content=$(echo "$content" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# Read the content line by line
while IFS= read -r line
do
  if [[ $line == \#* ]]; then
    # Extract the date from the line (without the hashtag and space)
    date=$(echo "$line" | sed 's/# //')
    # Create the filename with the date and .md extension
    filename="${output_folder}/${date}.md"
    # Initialize the file with the current line
    echo "$line" > "$filename"
  else
    # Append the current line to the existing file
    echo "$line" >> "$filename"
  fi
done <<< "$content"
