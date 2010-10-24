#!/bin/sh

cd "`dirname $0`"
fmt=.mobi
base=/tmp/Kindle$$
sudo rm -rf  "$base"
sudo mkdir "$base"

sudo umount /dev/disk/by-label/Kindle

sudo mount /dev/disk/by-label/Kindle "$base" -o uid=`id -u`

for p in *recipe; do 
  rm "$base/dagens_${p%.recipe}$fmt"
  ebook-convert "$p" "$base/dagens_${p%.recipe}$fmt"

done

sudo umount "$base"
sudo rm -rf "$base"
