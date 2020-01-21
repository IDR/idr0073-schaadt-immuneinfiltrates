#!/bin/bash

# Convert files using bioformats2raw + raw2ometiff
# Example usage:
# for i in `find . | grep .png`; do ./convert.sh $i; done

# path to bioformats2raw executable
bfraw=/home/dominik/convert/bioformats2raw-0.2.0-SNAPSHOT/bin/bioformats2raw

# path to raw2ometiff executable
rawtif=/home/dominik/convert/raw2ometiff-0.1.1-SNAPSHOT/bin/raw2ometiff

# temporary output directory
tmpdir=/tmp/output

# number of workers
workers=1

# max memory
mem=8G

#################

export BF_MAX_MEM=$mem

input=$1

if [ "$#" -ne 1 ]; then
    echo "Usage: ./convert.sh path/to/imagefile.png"
    exit 1
fi

input=`readlink -f $input`
output=${input%.*}.ome.tiff

mkdir $tmpdir

$bfraw $input --max_workers=$workers $tmpdir

$rawtif $tmpdir $output

rm -rf $tmpdir

