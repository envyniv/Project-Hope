extends StaticBody2D

var genobj

func can_interact(interactParent : Node) -> bool:
	return interactParent is Player

func _interact(_interactParent : Node) -> void:
	SaveLoad.inShop=true
