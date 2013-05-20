#!/bin/bash

make="Konica"
model="Hexar"
tid="00:00:00"
dato=$1
timestamp="$dato $tid" 
bilde=$2

echo "set Exif.Image.DateTimeOriginal $timestamp" "$bilde"

exiv2 -M "set Exif.Image.DateTimeOriginal $timestamp" "$bilde"
exiv2 -M "set Exif.Image.Make $make" "$bilde"
exiv2 -M "set Exif.Image.Model $model" "$bilde"
