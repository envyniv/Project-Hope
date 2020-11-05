extends Area2D

class_name HitBox

func _on_DamageBox_area_entered(area):
	if area.get_parent() != get_parent():
		if area.get_parent().has_method("_calc_damage"):
			area.get_parent()._calc_damage()
		else:
			pass
	pass # Replace with function body.
