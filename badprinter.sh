#!/bin/bash

# This script attempts to change all colors
# in a pdf file to a specified color.
# 
# Options:
#       -f <infile, required> -c <color, optional> -o <outfile, optional>
#
# The default color is blue.
# The default outfile name is out.pdf
#
# Requires:
#       * qpdf        [ tested with qpdf 8.0.2        ]
#       * ImageMagick [ tested with ImageMagicg 6.9.7 ]
#
# License: MIT
# Copyright 2023 Debajoy Das

if ! [ -x "$(command -v qpdf)" ]; then
  echo 'Error: qpdf is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v convert)" ]; then
  echo 'Error: ImageMagick is not installed.' >&2
  exit 1
fi

color=blue
outFile=out.pdf

while getopts f:c:o: opt
do
    case "${opt}" in
        f) file="${OPTARG}";;
        c) color="${OPTARG}";;
        o) out="${OPTARG}";;
    esac
done

pages=`qpdf --show-npages "${file}"`
next=1
files=1

echo "Creating temporary files.."
while [ $((pages-next+1)) -gt 15 ]
do
    qpdf --verbose --empty --pages "$file" $next-$((next+14)) -- out-${files}.pdf
    next=$((next+15))
    files=$((files+1))
done
    
qpdf --verbose --empty --pages "$file" $next-z -- out-${files}.pdf

echo "Converting text color.."
for (( i=1; i<=$files; i++ ))
do
    convert -density 300 out-${i}.pdf -fuzz 55% -fill $color -opaque "#e1342d" out-${i}-${color}.pdf
done

echo "Joining files.."
inputFiles=''
for (( i=1; i<=$files; i++ ))
do
    inputFiles="${inputFiles} out-${i}-${color}.pdf"
done

qpdf --verbose --empty --pages $inputFiles -- "$outFile"
echo "New pdf saved as $outFile with text color: $color."

echo "Removing temporary files.."
for (( i=1; i<=$files; i++ ))
do
    rm -v out-${i}.pdf
    rm -v out-${i}-${color}.pdf
done

echo "Done"

