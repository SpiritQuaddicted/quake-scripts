#!/bin/sh
# usage:
# adjust the quakedir and storagedir, then
# $ sh ~/capturedemo.sh honey/oulala.dem

# WARNING, this assumes there are no errors

# the ffmpeg settings are for GL_NEAREST_MIPMAP_LINEAR
# if you use ugly filtering, you will be able to use a lower crf

file=$1 # id1/maniac11-normal-SpiritQuaddict.dem
dir=$(echo ${file} | sed 's/\/.*//') # id1
demoname=$(basename -s .dem ${file}) # maniac11-normal-SpiritQuaddict

quakedir=~/games/quake/
storagedir=~/games/quake/movies/

cd ${quakedir}

# __GL_FSAA_MODE=12 is 16xQ according to
# ftp://download.nvidia.com/XFree86/Linux-x86_64/165.33.09/README/chapter-11.html
# no idea if I chose it for a reason, maybe the highest my card supports.

# +gamma is applied to the captured video if the engine runs in fullscreen

__GL_FSAA_MODE=12 ./reQuiem-spirit-quitsaftercapturedemo.glx -snddev /dev/dsp -heapsize 128000 -width 1280 -height 720 -bpp 32 -stdout +gamma 0.7 +volume 0.7 -game "${dir}" +capturedemo "${demoname}"

# since my engine "fork" quits hard, I have to reset the resolution <3
# no idea why it needs the 0 first
xrandr -s 0
xrandr -s 1680x1050

if [[ -e "${dir}/${demoname}.avi" ]]; then
	ffmpeg -i "${dir}/${demoname}.avi" -acodec libmp3lame -ab 192k -vcodec libx264 -preset slow -crf 18 "${storagedir}/${demoname}.mkv"

	# remove the huge avi
	rm "${dir}/${demoname}.avi"

	# move the .dem file
	mv ${file} ${storagedir}

fi


# to concat files (because of reloads or level changes)
# http://ffmpeg.org/trac/ffmpeg/wiki/How%20to%20concatenate%20(join%2C%20merge)%20media%20files#demuxer
# make sure the input files have the same characteristics...
# if your audio sample rates differ, it will result in poop
# 44.1kHz is good.

# To capture 1920x1080 on a smaller desktop, use nvidia-settings
# Display Configuration -> Advanced -> Panning
# 2000x1300 works well, otherwise if capturing a window part of the image will be cropped
