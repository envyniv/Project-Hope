extends Area2D
class_name Warp, "res://scenes/icons/interact.png"
export(String) var stage
#		**Warps should interact with COLLISIONS, NOT INTERACTIONS layers.**
func _on_Warp_area_entered(_area):
	SaveLoad.switch_stage={true:stage}
