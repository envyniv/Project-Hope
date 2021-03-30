extends Control
class_name InteractionUI

onready var interact = get_node("../Interact")

onready var interact_texrect = $HBoxContainer/TextureRect
onready var interact_label = $HBoxContainer/Label
export var interaction_texture : Texture
export var interaction_text : String

var fixed_position : Vector2

func _ready():
	interact.connect("on_interactable_changed", self, "interactable_target_changed", [], CONNECT_DEFERRED)
	hide()
	
func _process(delta : float):
	set_global_position(fixed_position)

func interactable_target_changed(newInteractable : Node) -> void:
	# If the new interactable thing is null it means we've moved out of range
	# Lets hide our UI
	if (newInteractable == null):
		hide()
		return
	# We'll update our texture and text
	interact_texrect.texture = interaction_texture
	interact_label.text = interaction_text
	
	# Record the position we should fix ourselves to
	# This should be just above the interactable item
	fixed_position = Vector2(newInteractable.get_global_position().x, newInteractable.get_global_position().y - 50)
	
	# Move to our fixed position
	self.set_global_position(fixed_position)
	
	# Then ensure we show ourselves
	show()
