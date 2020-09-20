extends Node

signal scene_changed()

onready var animation_player=$CanvasLayer/AnimationPlayer
onready var color_rect=$CanvasLayer/Control/ColorRect
onready var stage=get_tree().get_nodes_in_group("stage")

func change_scene(path,delay) :
	yield(get_tree().create_timer(delay),"timeout")
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	#get nodes that are part of a "stage" group and swap their children with the instanced scene
	get_node("%s/" % [stage])
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
	pass
