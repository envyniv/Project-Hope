extends Resource
# FIXME: MAKE CONTROLS REBOUNDABLE BUT ONLY FOR KEYBOARD
class_name Settings
#sys
export(Array) var mods

#settings
export(float) var sfxvol = 1.000
export(float) var bgmvol = 1.000
export(bool) var voice = true
export(int, 1, 3) var scale = 1
export(String) var lang = "en"
