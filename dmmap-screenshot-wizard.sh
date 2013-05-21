#!/bin/sh
# makes 4 spawnpoint screenshots of a list of maps

# NEEDS xte from xautomation

# disable focus stealing prevention in your WM or the engine won't receive the keys
# anti-aliasing ON
# you might want to adjust the sleep times depending on your machine

# you need some stuff in your cfg:
## bind "k" "kill"
## con_notifylines "0"
## crosshair "0"
## fov "110"
## gl_max_size "4096" # why?
## r_drawviewmodel "0"
## scr_showfps "0"
## viewsize "120"
## gl_texturemode "GL_NEAREST_MIPMAP_LINEAR"
## scr_sshot_format "png"

while read filename ; do
	cd ~/games/quake/ && ./reQuiem.glx -nosound -heapsize 128000 -width 1024 -height 768 -bpp 32 -window -stdout -game screenshots +deathmatch 1 +map ${filename} &
	sleep 2.5
	xte "key F12" && sleep 0.4
	xte "key k" && sleep 0.7 && xte "key F12" && sleep 0.4
	xte "key k" && sleep 0.7 && xte "key F12" && sleep 0.4
	xte "key k" && sleep 0.7 && xte "key F12" && sleep 0.4
	killall reQuiem.glx
	sleep 1
done < maplist
