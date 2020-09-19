extends Node

onready var world = $HBoxContainer/Game/Viewport/World
onready var camera = $HBoxContainer/Game/Viewport/Camera2D
onready var diagbox = $HBoxContainer/Game/DiagBox
onready var player = $HBoxContainer/Game/Viewport/World/YSort/Player

func _ready():
	camera.target = world.get_node("YSort/Player")
	player.inputChk(1)
	pass

