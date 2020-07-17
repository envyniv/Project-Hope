
cd ./source_assets/OST/BGM
for i in *.mp3; do ffmpeg -i "$i" -ar 48000 -vn -c:a libvorbis "${i%.*}.ogg"; done
cd ../fx
for i in *.mp3; do ffmpeg -i "$i" "${i%.*}.wav"; done
exit
