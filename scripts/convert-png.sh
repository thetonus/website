#!/bin/bash

set -eou pipefail

# Convert PNG to Webp using cwebp
# https://www.ticktechtold.com/install-convert-images-into-webp-mac/
for i in "$PWD"/public/assets/**/*.png ; do cwebp -q 80 "$i" -o "${i%.*}.webp" ; done

