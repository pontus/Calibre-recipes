#!/bin/sh

cd "`dirname $0`"
git pull

fmt=.mobi
base=/media/Kindle

umount /dev/disk/by-label/Kindle

mount "$base"

for p in *recipe; do 
  rm "$base/dagens_${p%.recipe}$fmt"
  ebook-convert "$p" "$base/dagens_${p%.recipe}$fmt"

done

umount "$base"
