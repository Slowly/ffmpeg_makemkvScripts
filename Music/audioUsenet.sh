#!/bin/bash
# Process and normalize only
# for files downloaded from Usenet
# this might not work well if downloaded
# filenames have more than one period

# convert to mp3 44x128, normalize, then delete processed audio (flac)
# or delete the temporary mp3 file.
# the loop will execute at least once even if a file doesn't exist, 
# which confuses sox. So we have to test for file existence. the word
# 'then' MUST be on the next line; it's a bash quirk. '&&' means only
# do the next command if the previous command worked.
for i in *.mp3 *.flac; do 
  if [ -f "$i" ] 
  then 
    name="${i%.*}"
    extension="${i##*.}"
    if [[ $extension == "flac" ]]
    then
      ffmpeg -i "$i" -ar 44100 -b:a 128k -f mp3 pipe:1 | sox --type mp3 --norm - "${name}.mp3" &&
      rm "$i";
    fi
    if [[ $extension == "mp3" ]]
    then
      ffmpeg -i "$i" -ar 44100 -b:a 128k -type mp3 - | sox type mp3 --norm - temp.mp3 &&
      cp temp.mp3 "$i" &&
      rm temp.mp3;
    fi
  fi
 done
 