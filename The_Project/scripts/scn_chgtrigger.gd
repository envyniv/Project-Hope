extends Area2D
signal swap_node()
class_name Warp, "res://scenes/icons/interact.png"
export(String, FILE) var path
#export(NodePath) var node_to_swap
	#Warps interact with COLLISIONS, NOT INTERACTIONS layers.
func _on_Warp_area_entered(_area):
	SceneChanger.swap_node(get_node("../../Stage"),path,0)
	pass # Replace with function body.

func _ready():
	#print(str(path))
	pass
