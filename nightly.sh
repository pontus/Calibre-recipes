#!/bin/sh

cd "`dirname $0`"
fmt=.mobi
base=/media/Kindle

sudo umount "$base"
sudo mount "$base" -o user=pontus

for p in *recipe; do 
  rm "$base/dagens_${p%.recipe}.$fmt"
  ebook-convert ${p%.recipe} $base/dagens_${p%.recipe}.$fmt"
done

sudo umount "$base"
