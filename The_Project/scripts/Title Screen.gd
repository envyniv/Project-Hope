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
	pass

func _new_pressed():
	SceneChanger.change_scene("res://scenes/Viewports.tscn",0)
	pass
	
func _load_pressed():
	#SceneChanger.change_scene("res://scenes/Load.tscn",0)
	pass
	
func _set_pressed():
	#SceneChanger.change_scene("res://scenes/Settings.tscn",0)
	pass
	
func _exit_pressed():
	get_tree().quit()
	pass
