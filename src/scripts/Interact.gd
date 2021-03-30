extends Area2D

enum possible {NPC, OBJECT, ITEM}

export (possible) var type
export var interaction_parent : NodePath
signal on_interactable_changed(newInteractable)
var interaction_target : Node

func _process(_delta):
	if (interaction_target != null && Input.is_action_just_pressed("ui_accept")):
		if (interaction_target.has_method("_interact")):
			interaction_target._interact(self)

func _on_Interact_area_entered(area):
	print("enter")
	var canInteract := false
	
	if (area.has_method("can_interact")):
		canInteract = area.can_interact(get_node(interaction_parent))

	if !canInteract:
		return

	interaction_target = area
	emit_signal("on_interactable_changed", interaction_target)

func _on_Interact_area_exited(area):
	if (area == interaction_target):
		interaction_target = null
		emit_signal("on_interactable_changed", null)
	print("exit")
