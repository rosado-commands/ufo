#!/bin/bash

# Check if both input arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 input_image.jpg background_image.jpg"
    exit 1
fi

# Extract input arguments
input_image=$1
background_image=$2

# Check if input images exist
if [ ! -f "$input_image" ]; then
    echo "Error: Input image '$input_image' not found"
    exit 1
fi

if [ ! -f "$background_image" ]; then
    echo "Error: Background image '$background_image' not found"
    exit 1
fi

# Create a black background image with dimensions 1920x600
# convert -size 1920x600 xc:black black_background.jpg

# Crop the input image to 1920x600
magick "$input_image" -resize 1920x600 -gravity center -alpha set -channel A -evaluate set 50% cropped_input.jpg

# Crop the background image to 1920x600
magick "$background_image" -resize 1920x600! -gravity center background_image.jpg

# Paste the cropped input image onto the background image, centered
composite -gravity center cropped_input.jpg background_image.jpg final_output.jpg

echo "Final output generated: final_output.jpg"
