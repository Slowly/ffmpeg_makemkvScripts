#!/bin/bash

#process a single movie: convert from MKV to MP4, set bitrate and frame rates depending on class, remove subtitles
# and other extraneous streams

# resyncing audio (fixing virtualdub error)
# test
#ffmpeg -i "/Volumes/Aslan/Movies/Joy [UHD] [SOUNDNOTSYNCEDSLIGHTLY] (2015).mp4" -itsoffset 0.22 -i "/Volumes/Aslan/Movies/Joy [UHD] [SOUNDNOTSYNCEDSLIGHTLY] (2015).mp4" -map 0:v -map 1:a -ss: 00:05:00 -t: 00:05:00 -c copy "a2.mp4"
# allofit
#ffmpeg -i "/Volumes/Aslan/Movies/Joy [UHD] [SOUNDNOTSYNCEDSLIGHTLY] (2015).mp4" -itsoffset 0.22 -i "/Volumes/Aslan/Movies/Joy [UHD] [SOUNDNOTSYNCEDSLIGHTLY] (2015).mp4" -map 0:v -map 1:a -c copy "/Volumes/Aslan/Movies/Joy [UHD] [SOUNDNOTSYNCEDSLIGHTLY] (2015)2.mp4"

# VHS (before 1995)
# ffmpeg -i TheBounty1984.mkv -sn -r 24 -vf scale=720x480 out.mp4

# DVD (480p) (after 1995)
#ffmpeg -i a.mp4 -sn -b:v 1M -r 25 -vf scale=720:480 "The Intern [DVD] (2015).mp4"

# HD (720p - 1080p) (after 2002)
#ffmpeg -i "Hangman1080p2017.mkv" -sn -b:v 3M -r 25 -vf scale=1280:720 "/Volumes/Aslan/Movies/Moontrap: Target Earth [HD] (2017).mp4"

# 2K (1080p) (after 2012)
#ffmpeg -i "Hangman1080p2017.mkv" -sn -b:v 7M -r 30 -vf scale=2048:1080 "/Volumes/Aslan/Movies/Hangman [2K] (2017).mp4"

# UHD4K (2160p) (after 2016)
#ffmpeg -i "TheCommuter2018.mkv" -sn -b:v 11M -r 30 -vf scale=3840:2160 -ss: 00:10:00 -t: 00:05:00 test.mp4
#ffmpeg -i "MollysGame2017_1080p.mkv" -sn -b:v 9M -r 30 -vf scale=2048:1080 "/Volumes/Aslan/Movies/Mollys Game [2K] (2017).mp4"

# CREATE AUDIO SAMPLE FOR CINAVIA (yes, CinDe can detect cinavia with only audio)
#ffmpeg -i a.mkv -sn -ss: 00:10:00 -t: 00:20:00 test.mp3
