extends Area2D
class_name Warp, "res://scenes/icons/interact.png"
export(String, FILE) var path
onready var node=get_node("../../")
#Warps interact with COLLISIONS, NOT INTERACTIONS layers.
func _on_Warp_area_entered(_area):
	#SceneChanger.swap_node(node,path,0)
	get_parent().SceneChanger.change_scene(path,0)
	pass # Replace with function body.

func _ready():
	pass
