extends Node
class_name InteractableItem

# By default interactable items are only availble to the Player class
func can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player