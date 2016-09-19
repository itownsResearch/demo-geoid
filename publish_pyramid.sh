#!/bin/bash

file=$1
levels=$2
height=$3
base=$4
format=$5
ext=$6

mkdir -p $base
gdal_translate -outsize $((height*2)) $height -a_srs "+init=epsg:4326" -a_ullr 0 180 360 0 $file $base/$base.tif

rm -rf $base/tif
mkdir $base/tif
gdal_retile.py -v -ps 256 256 -targetDir $base/tif -levels $levels $base/$base.tif
mkdir $base/tif/0
mv $base/tif/*.tif $base/tif/0

rm -rf $base/$ext
mkdir $base/$ext
n=1;
for (( k=0; k <= $levels; k++ )); do 
	mkdir $base/$ext/$k
    k2=$(($levels-k))
	for (( i=0; i < $n; i++ )); do 
		for (( j=0; j < 2*$n; j++ )); do 
			if [ -f $base/tif/$k2/${base}_$(($i+1))_$((j+1)).tif ]
			then 
				gdal_translate -of $format $base/tif/$k2/${base}_$(($i+1))_$((j+1)).tif $base/$ext/$k/${base}_${j}_${i}.$ext
			fi
			if [ -f $base/tif/$k2/${base}_0$(($i+1))_$((j+1)).tif ]
			then 
				gdal_translate -of $format $base/tif/$k2/${base}_0$(($i+1))_$((j+1)).tif $base/$ext/$k/${base}_${j}_${i}.$ext
			fi
			if [ -f $base/tif/$k2/${base}_$(($i+1))_0$((j+1)).tif ]
			then
				gdal_translate -of $format $base/tif/$k2/${base}_$(($i+1))_0$((j+1)).tif $base/$ext/$k/${base}_${j}_${i}.$ext
			fi
			if [ -f $base/tif/$k2/${base}_0$(($i+1))_0$((j+1)).tif ] 
			then
				gdal_translate -of $format $base/tif/$k2/${base}_0$(($i+1))_0$((j+1)).tif $base/$ext/$k/${base}_${j}_${i}.$ext
			fi
		done
	done
	n=2*$n;
done
