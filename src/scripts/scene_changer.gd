extends Node

signal scene_changed()
onready var animation_player=$CanvasLayer/AnimationPlayer
onready var color_rect=$CanvasLayer/Control/ColorRect

func change_scene(path,delay):
	transition_start(delay)
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	transition_end()
	yield(animation_player, "animation_finished")
	pass

func transition_start(delay):
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("fade")

func transition_end():
	animation_player.play_backwards("fade")
	emit_signal("scene_changed")
	pass
