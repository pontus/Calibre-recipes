#!/bin/sh

cd "`dirname $0`"
git pull

fmt=.mobi
base=/media/Kindle
docbase=$base/documents/tidningar

umount "$base"
mount "$base"

for p in *recipe; do 
  rm "$docbase/dagens_${p%.recipe}$fmt"
  ebook-convert "$p" "$docbase/dagens_${p%.recipe}$fmt"

done

umount "$base"
