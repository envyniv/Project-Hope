extends Node

signal scene_changed()

onready var animation_player=$CanvasLayer/AnimationPlayer
onready var color_rect=$CanvasLayer/Control/ColorRect


func change_scene(path,delay) :
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	#get "stage", check prerequisites and swap it
	#get_node
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	pass
