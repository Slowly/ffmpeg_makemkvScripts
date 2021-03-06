#!/bin/bash
#download and process a single playlist (album)
# google search parameters: 
#  " albumName " [inurl:playlist] ["artistName - topic"] [+inurl:("/channel/")] site:youtube.com

youtube-dl -ci <playlist URL>

# convert to mp3 44x128, normalize, then delete the processed video.
# the loop will execute at least once even if a file doesn't exist, 
# which confuses sox. So we have to test for file existence. the word
# 'then' MUST be on the next line; it's a bash quirk. '&&' means only
# do the next command if the previous command worked.
for i in *.mkv *.mp4 *.webm; do 
  if [ -f "$i" ] 
  then  
    name=`echo $i | cut -d'.' -f1`;
    ffmpeg -i "$i" -ar 44100 -b:a 128k -f mp3 pipe:1 | sox --type mp3 --norm - "${name}.mp3" &&
    rm "$i";
  fi
 done