extends Node

onready var world = $HBoxContainer/Game/Viewport/World
onready var stage = $HBoxContainer/Game/Viewport/World/Stage/YSort
onready var camera = $HBoxContainer/Game/Viewport/Camera2D
onready var diagbox = $HBoxContainer/Game/DiagBox
onready var player = $HBoxContainer/Game/Viewport/World/YSort/Player

func _ready():
	camera.target = player
	#get how many photobooths there are and assign an id to all of them
	pass

