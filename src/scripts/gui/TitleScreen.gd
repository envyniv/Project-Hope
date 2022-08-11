extends Node
tool

onready var new      = $Control/Menu/new
onready var set      = $Control/Menu/settings
onready var exit     = $Control/Menu/exit
onready var setPopup = $Control/Menu/settings/Settings/Popup
onready var setnode  = $Control/Menu/settings/Settings
var version          = ProjectSettings.get("application/config/AppVersion")

func _ready() -> void:
  new.grab_focus()
  new.connect("pressed", self, "_new_pressed")
  set.connect("pressed", self, "_set_pressed")
  exit.connect("pressed", self, "_exit_pressed")
  $Copyright/Version.text = "Version %s" % str(version)
  return

func _new_pressed() -> void:
  SceneManager.change_scene("filemenu",0)
  return

func _set_pressed() -> void:
  setPopup.popup()
  return

func _exit_pressed() -> void:
  get_tree().quit()
  return
