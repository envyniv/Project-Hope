extends Node2D


class_name Vending, "res://scenes/icons/vending.png"
#TODO: finally make this work
func _ready():
	pass # Replace with function body.

func _interact():
	set_process_input(true)

func _input(event):
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var RIGHT = Input.is_action_pressed("ui_right")
	var LEFT = Input.is_action_pressed("ui_left")
	var ACCEPT = Input.is_action_pressed("ui_accept")
	var CANCEL = Input.is_action_pressed("ui_cancel")
