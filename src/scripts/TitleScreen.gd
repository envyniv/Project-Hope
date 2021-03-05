extends Node

onready var new = $Control/Menu/new
onready var lload = $Control/Menu/load
onready var set = $Control/Menu/settings
onready var exit = $Control/Menu/exit
var version = ProjectSettings.get("application/config/AppVersion")

func _ready():
	new.connect("pressed", self, "_new_pressed")
	lload.connect("pressed", self, "_load_pressed")
	set.connect("pressed", self, "_set_pressed")
	exit.connect("pressed", self, "_exit_pressed")
	if SaveLoad.save_check():
		lload.show()
	$Copyright/Version.text="Version %s" % str(version)
	pass

func _new_pressed():
	SceneChanger.change_scene("game")
	
func _load_pressed():
	SaveLoad.load_game()
	SceneChanger.change_scene("game")
	#parsing data should be done in viewports
	pass
	
func _set_pressed():
	SceneChanger.change_scene("settings")
	pass
	
func _exit_pressed():
	get_tree().quit()
	pass
