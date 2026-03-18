#!/bin/bash
mkdir -p ~/gaussian_project/input
ffmpeg -i ~/gaussian_project/walkthrough.mp4 \
    -vf "fps=2,mpdecimate=hi=64*12:lo=64*5:frac=0.33,scale=1920:-2" \
    -q:v 2 \
    ~/gaussian_project/input/frame_%05d.jpg
echo "Frames extracted: $(ls ~/gaussian_project/input/ | wc -l)"