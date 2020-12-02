#!/bin/sh

suffix=".mov"
original_file=$1
root_name=${original_file%"$suffix"}
if [ -z $2 ]
then
    gif_name="$root_name.gif"
else
    gif_name=$2
fi
mp4_name="$root_name.mp4"

echo "Step 1/2"
ffmpeg -v warning -i "$original_file" "$mp4_name"
echo "Step 2/2"
ffmpeg -v warning -i "$mp4_name" -vf "fps=10,scale=720:-1:flags=lanczos" -c:v pam -f image2pipe - | convert -delay 10 - -loop 0 -layers optimize "$gif_name"
rm "$mp4_name"
echo "Done"
