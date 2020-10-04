extends Area2D

class_name OBJ_Interact, "res://scenes/icons/interact.png"
	
func _on_Interact_area_entered(area):
	if get_parent().has_method("_interact"):
		get_parent()._interact()
	pass
