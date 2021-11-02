scons -j$(nproc) platform=windows target=release bits=64
scons -j$(nproc) platform=x11 target=release bits=64
strip bin/godot.windows.opt.64.exe
strip bin/godot.x11.opt.64
mkdir bin/templates
mv bin/godot.x11.opt.64 bin/templates/linux_x11_64_release
mv bin/godot.windows.opt.64.exe bin/templates/windows_64_release.exe
upx -9 bin/templates/linux_x11_64_release
upx -9 bin/templates/windows_64_release.exe
touch bin/templates/version.txt
echo "3.3.2.stable" > bin/templates/version.txt
7z a export_templates_custom.zip ./bin/*
mv export_templates_custom.zip export_templates_custom.tpz
rm -rf bin/*