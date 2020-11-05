extends Area2D

class_name Interact, "res://scenes/icons/interact.png"
	
func _on_Interact_area_entered(area):
	if area.get_parent()!=get_parent():
		if area.get_parent().has_method("_interact"):
			area.get_parent()._interact()
	pass
