extends StaticBody2D

# TODO: FINISH THIS
func _ready():
	pass

func can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func _interact(_interactionComponentParent : Node) -> void:
	pass