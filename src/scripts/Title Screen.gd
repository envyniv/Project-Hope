extends Node

onready var new = $Control/Menu/new
onready var lload = $Control/Menu/load
onready var set = $Control/Menu/settings
onready var exit = $Control/Menu/exit

func _ready():
	new.connect("pressed", self, "_new_pressed")
	lload.connect("pressed", self, "_load_pressed")
	set.connect("pressed", self, "_set_pressed")
	exit.connect("pressed", self, "_exit_pressed")
	_probe_files()
	SaveLoad.load_set()
	pass

func _new_pressed():
	SceneChanger.change_scene("res://scenes/Viewports.tscn",0)
	
func _load_pressed():
	SaveLoad.load_game()
	#parse data and stuff
	pass
	
func _set_pressed():
	SceneChanger.change_scene("res://scenes/Settings.tscn",0)
	pass
	
func _exit_pressed():
	get_tree().quit()
	pass
	
func _probe_files():
	var files = []
	var dir = Directory.new()
	dir.open("res://scripts/dialogue")
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()
	#ProjectSettings.load_resource_pack("res://mod.pck")
	#var imported_scene = load("res://mod_scene.tscn")
	return files
	pass
