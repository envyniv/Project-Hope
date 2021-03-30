extends StaticBody2D

# TODO: FINISH THIS
var used := false

func can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func _interact(_interactionComponentParent : Node) -> void:
	if used:
		return

	$Booth/Curtain/AnimationPlayer.play("photo")
	used = true
	collision_layer = collision_layer ^ 4
	print("save")