#!/bin/sh

# Check basic connectivity before we do anything
ping -c 3 www.google.com || exit 1

cd "`dirname $0`"
git pull

fmt=.epub
docbase=/tmp/calibrecip$$
remotebase="/media/My Files/Newspapers/"

mkdir -p "$docbase"

for p in *recipe; do 
  rm -rf "$docbase/dagens_${p%.recipe}$fmt"
  ebook-convert "$p" "$docbase/dagens_${p%.recipe}$fmt" --output-profile=nook --prefer-metadata-cover
done

done=no

cd "$docbase"
runs=0

while [ "x$done" != xyes ]; do
 
  if /usr/local/android/android-sdk-linux_x86/platform-tools/adb connect 192.168.15.143:5555; then
    tr=yes
    for p in *; do
      if /usr/local/android/android-sdk-linux_x86/platform-tools/adb push "$p" "$remotebase"; then
        :
      else
        tr=no
      fi
    done

    done="$tr"
  else
    sleep 15
  fi

  runs=$((runs+1))
  if [ "$runs" -gt 5000 ]; then
    # give up after 5000 rounds
    done=yes
  fi
done

rm -rf "$docbase"

