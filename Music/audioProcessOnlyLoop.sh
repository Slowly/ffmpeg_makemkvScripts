#!/bin/bash

for i in *.mkv *.mp4 *.webm; do 
  if [ -f "$i" ] 
  then  
    name=`echo $i | cut -d'.' -f1`;
    ffmpeg -i "$i" -ar 44100 -b:a 128k -f mp3 pipe:1 | sox --type mp3 --norm - "${name}.mp3" &&
    rm "$i";
  fi
 done
 