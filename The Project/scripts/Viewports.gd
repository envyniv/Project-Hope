extends Node

onready var world = $HBoxContainer/Game/Viewport/World
onready var camera = $HBoxContainer/Game/Viewport/Camera2D

func _ready():
	camera.target = world.get_node("YSort/Player")
	pass
