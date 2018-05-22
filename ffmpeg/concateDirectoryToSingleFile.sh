#!/bin/bash
#concatenate all MP4 files in a directory into one file no reencoding
ffmpeg -f concat -i <(for f in ./*.mp4; do echo "file '$PWD/$f'"; done) -c copy output.mp4