extends Area2D
class_name Warp, "res://scenes/icons/interact.png"
export(String) var stage
signal change_stage()
#Warps interact with COLLISIONS, NOT INTERACTIONS layers.
# TODO:
func _on_Warp_area_entered(_area):
	connect("change_stage", SceneChanger, "swap_stage")
	emit_signal("change_stage",stage.to_lower())
	self.queue_free()
	pass # Replace with function body.
