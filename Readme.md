# Image Resizer Script

## Overview
The Image Resizer Script is a Bash script designed to automatically resize all images within a specified directory to a set of given dimensions. It checks if ImageMagick is installed on the system and installs it if necessary. The script can process multiple size specifications at once and checks if each image's dimensions are larger than the specified sizes before resizing to avoid upscaling smaller images.

## Dependencies

- ImageMagick
- `file` command utility

## Installation

### Installing Dependencies
Before using the script, make sure that the required dependencies are installed on your system, otherwise the script will ask for sudo rights to install them.

```
sudo apt-get update
sudo apt-get install imagemagick file -y
```

### Script Installation

1 - Download the script to your preferred directory.
2 - Make the script executable:
`chmod +x resize_images.sh`

## Usage

To use the script, navigate to the directory where the script is located and run:
`script.sh <path_to_image_directory> <size1> [size2] ...`

- <path_to_image_directory>: The directory containing the images you wish to resize.
- <size1> [size2] ...: One or more target sizes for the images, specified in the format WIDTHxHEIGHT (e.g., 800x600).
  
### Example 

To resize all images in the directory /home/user/images to both 512x512 and 900x600, run:

`script.sh /home/user/images 512x512 900x600`

## Notes

- The script checks if the actual size of each image is greater than the specified target size(s) before resizing. If an image is smaller than or equal to the target size, the script will skip resizing for that specific size and print an error message.
- Resized images are saved in the same directory as the original images, with filenames indicating their new dimensions (e.g., image-512x512.png).