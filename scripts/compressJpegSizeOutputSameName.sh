#!/bin/bash
#magick source.jpg -strip -interlace Plane -gaussian-blur 0.05 -quality 85% result.jpg
magick $1 -strip -interlace Plane -gaussian-blur 0.05 -quality 85% $1
