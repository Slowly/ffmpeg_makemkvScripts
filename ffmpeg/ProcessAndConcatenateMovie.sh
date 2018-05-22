
#!/bin/bash
#process an entire series and concatenate it into a single movie file
ffmpeg -i 1.mkv -t 2806 -sn -b:v 6.5M 1.mp4
ffmpeg -i 2.mkv -t 2840 -sn -b:v 6.5M 2.mp4
ffmpeg -i 3.mkv -t 2836 -sn -b:v 6.5M 3.mp4
ffmpeg -i 4.mkv -t 2836 -sn -b:v 6.5M 4.mp4
ffmpeg -i 5.mkv -t 2839 -sn -b:v 6.5M 5.mp4
ffmpeg -i 6.mkv -sn -b:v 6.5M 6.mp4

ffmpeg -f concat -safe 0 -i <(for f in ./*.mp4; do echo "file '$PWD/$f'"; done) -c copy output.mp4

