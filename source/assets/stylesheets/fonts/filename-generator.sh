#/bin/bash
# example usage: sh filename-generator.sh <font filename>

set -eu

filename=${1?Usage: $0 <filename>}

md5hash=$( md5 -q "$filename" | cut -c -10 )
filename_ext=${filename##*.}

echo -n "What is the version number? [default: 1] "
read -r version
: "${version:=1}"

echo -n "What type of font (e.g. tabular)? [default: ''] "
read -r ftype
: "${ftype:=}"

echo -n "What is the weight of the font? [default: light] "
read -r weight
: "${weight:=light}"

echo "v${version}-${md5hash}-${ftype:+${ftype}-}${weight}.${filename_ext}"