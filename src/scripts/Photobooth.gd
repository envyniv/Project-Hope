extends StaticBody2D

# TODO: FINISH THIS
export (String) var map
var used := false

func can_interact(interactParent : Node) -> bool:
	return interactParent is Player

func _interact(_interactParent : Node) -> void:
	if used:
		return
	SaveLoad.data["location"]={"map":map}
	$Booth/Curtain/AnimationPlayer.play("photo")
	used = true
	collision_layer = collision_layer ^ 4
	
	SaveLoad.save_game()
	print("save")
