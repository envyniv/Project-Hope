extends Node

onready var new = $Control/Menu/new
#onready var lload = $Control/Menu/load
onready var set = $Control/Menu/settings
onready var exit = $Control/Menu/exit
onready var player = $AudioStreamPlayer
var version = ProjectSettings.get("application/config/AppVersion")

func _ready():
  #new.set_focus_mode(Control.FOCUS_ALL)
  new.grab_focus()
  new.connect("pressed", self, "_new_pressed")
  #lload.connect("pressed", self, "_load_pressed")
  set.connect("pressed", self, "_set_pressed")
  exit.connect("pressed", self, "_exit_pressed")
  if FileMan.save_check():
  #  lload.show()
    new.text="menuLoad"
  $Copyright/Version.text="Version %s" % str(version)
  player.volume_db=linear2db(FileMan.settings.bgmvol)
  player.play()

func _new_pressed():
    SceneManager.change_scene("filemenu",0)
  #if !FileMan.data.has("location"):
    #change_stage("meteora")

#func _load_pressed():
#    FileMan.load_game()
#    SceneManager.change_scene("meteora")
#    pass

func _set_pressed():
    SceneManager.change_scene("settings")
    pass

func _exit_pressed():
    get_tree().quit()
    pass
