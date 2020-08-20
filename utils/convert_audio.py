#!/bin/env python3
import os

os.chdir(../The_Project/source_assets/OST/BGM)
for x in *.mp3:
    os.system("ffmpeg -i '$i' -ar 48000 -vn -c:a libvorbis '${i%.*}.ogg'")
os.chdir(../fx)
for x in *.mp3:
    os.system("ffmpeg -i '$i' -ar 48000 -vn -c:a libvorbis '${i%.*}.ogg'")

quit()
