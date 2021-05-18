![Official Last Hope Logo](src/title.svg)
- - -
*My take on an RPG with fighting game styled battles with some minigames sprinkled on top.*

[Website](https://envyniv.github.io/Project-Hope)

> Coded in [Godot](https://godotengine.org/).

> PX Sans by [teryor](https://github.com/teryror/pixel-fonts)

> Camera2D ScreenShake effect based on [eyeEmotion](https://godotengine.org/qa/user/eyeEmotion)'s script

> Logo(s) by [Davide Azzaretto/envyniv](https://github.com/envyniv)

© Davide Azzaretto/envyniv, 2020.


## Twirl Pixel Members
### Game Designer(s):
* Davide Azzaretto (envyniv);

### Composer(s):
* David Kvistorf (davidkvis99);

### Sound Engineer(s)
* Davide Azzaretto (envyniv);
* David Kvistorf (davidkvis99);

### Sound Designer(s):
* Davide Azzaretto (envyniv);

### Coder(s):
* Davide Azzaretto (envyniv);

### Pixel Artist(s):
* Davide Azzaretto (envyniv);

### Writer(s):
* Davide Azzaretto (envyniv);

## Build/Compile/Export
### Manually:
* open the editor, remove export templates (if downloaded) and add the ones in `customtemplates`
* export, in order: PCK export setting, ZIP export setting zip archive only.
### Automatically:
* run `export.py` and wait.
### Notes:
* export templates were built on a Ubuntu 18.04 Server Virtual Machine.
* if, for whatever reason, they don't run on your pc, feel free to follow the following instructions.
### Compiling The Templates:
### Linux:
* download the godot 3.2.3-stable source code from [here](https://github.com/godotengine/godot/archive/3.2.3-stable.zip)
* download `custom.py` from [here](https://github.com/envyniv/Project-Hope/raw/master/customtemplates/custom.py)
* put custom.py in the godot source code folder
* [make sure you've got compiling dependencies installed](https://docs.godotengine.org/en/stable/development/compiling/compiling_for_x11.html)
* * Optional: [Cross compiling for Windows](https://docs.godotengine.org/en/stable/development/compiling/compiling_for_windows.html#cross-compiling-for-windows-from-other-operating-systems)
* * Optional: [Cross compiling for macOS](https://docs.godotengine.org/en/stable/development/compiling/compiling_for_osx.html#cross-compiling-for-macos-from-linux)
* either execute the following commands one-by-one or make a script:
```
scons platform=windows target=release bits=64
strip bin/godot.windows.opt.64.exe
scons platform=x11 target=release bits=64
strip bin/godot.x11.opt.64
mkdir bin/templates
mv bin/godot.x11.opt.64 bin/templates/linux_x11_64_release
mv bin/godot.windows.opt.64.exe bin/templates/windows_64_release.exe
touch bin/templates/version.txt
echo "3.2.3.stable" > bin/templates/version.txt
7z a export_templates_custom.zip ./bin/*
rm -rf bin/*
mv export_templates_custom.zip export_templates_custom.tpz
```
### Windows:
* install GNU [binutils](http://www.gnu.org/software/binutils/)
* download the godot 3.2.3-stable source code from [here](https://github.com/godotengine/godot/archive/3.2.3-stable.zip)
* download `custom.py` from [here](https://github.com/envyniv/Project-Hope/raw/master/customtemplates/custom.py)
* put custom.py in the godot source code folder
* [make sure you've got compiling dependencies installed](https://docs.godotengine.org/en/stable/development/compiling/compiling_for_windows.html)
* either execute the following commands one-by-one or make a script:
```
scons platform=windows target=release bits=64
strip bin/godot.windows.opt.64.exe
scons platform=x11 target=release bits=64
strip bin/godot.x11.opt.64
mkdir bin/templates
rn bin/godot.x11.opt.64 bin/templates/linux_x11_64_release
rn bin/godot.windows.opt.64.exe bin/templates/windows_64_release.exe
echo "3.2.3.stable" > bin/templates/version.txt
7z a export_templates_custom.zip ./bin/*
rd bin/*
rn export_templates_custom.zip export_templates_custom.tpz
```

## Special Thanks to:
* Everyone in [my discord server](https://discord.gg/bNkDkHW) for being supportive
* You (for acknowledging this game)
* Gzillion/Newbie (minor sprite work)
* Aléris (minor sprite work)
* gotimo2 (separated player movement and animation)
* Everyone from the [Godot Engine discord server](https://discord.gg/4JBkykG) that were willing to answer any question I'd ask!

## Contact

Wanna ask me something? send an email to envy67@pm.me
