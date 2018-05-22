#!/bin/bash
#download and process an array of playlists (an artists' entire discography!)
# google search parameters: 
#  " albumName " [inurl:playlist] ["artistName - topic"] [+inurl:("/channel/")] site:youtube.com

# 2-dimensional array of defining the discography. 
# we use arrays here because youtube-dl's download channel facility just throws everything 
# in one directory with no organization.
# Column 1 is the album name; column 2 is the playlist URL.
# you have to do it like this because bash doesn't support multi-D arrays.
# why for the love of mike that's true when vbscript and .net do 
# support multi-D arrays is beyond me.
declare -a albums;
declare -a videos;
  albums[0]="LondonCalling"
  albums[1]="Sandinista"
  albums[2]="CombatRock"
  albums[3]="CutTheCrap"
  videos[0]="https://www.youtube.com/playlist?list=PLBxvYgLehWxp5EE-jeB_cIAoc17I-383U"
  videos[1]="https://www.youtube.com/playlist?list=PLU_gJj2lNkka9aG0uwstchLOI_eQVQmeR"
  videos[2]="https://www.youtube.com/playlist?list=PLwb93tcz9e7_iiwMazUHNC6XHFtyS6e8a"
  videos[3]="https://www.youtube.com/playlist?list=PL2feUNzfWuY2zOHlbQ8oGh00UIlVk8S1S"

# main loop. Loop thru each playlist in the discography
for ((j=0;j<=${#albums[@]}-1;j++)) do
  mkdir ${albums[$j]};
  cd ${albums[$j]};
  # download the playlist
  youtube-dl -ci ${videos[$j]};
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
  #cd back out
  cd ..
 done