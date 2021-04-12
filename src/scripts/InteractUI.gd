extends Control

onready var interact = get_node("../Interact")
onready var interact_texrect = $HBoxContainer/TextureRect
onready var interact_label = $HBoxContainer/Label

const icons={
  "npc":preload("res://assets/gui/talk.png"),
  "object":preload("res://assets/gui/interacticon.png"),
  #"enemy":preload("res://assets/gui/fight.png"),
  "stair":preload("res://assets/gui/go.png"),
  "item":preload("res://assets/gui/pickup.png"),
}

var fixed_position : Vector2

func _ready():
  interact.connect("target_changed", self, "target_changed", [], CONNECT_DEFERRED)
  hide()

func _process(_delta):
  set_global_position(fixed_position)

func target_changed(newInteractable : Node) -> void:
	# If the target is null we're not interacting.
	if (newInteractable == null):
		hide()
		return
	if "stage" in newInteractable:
		interact_texrect.texture=icons.stair
		interact_label.text="Go To..."
	elif "map" in newInteractable:
		interact_texrect.texture=icons.object
		interact_label.text="Save..."
	elif "genobj" in newInteractable:
		interact_texrect.texture=icons.object
		interact_label.text="Interact"
	elif "item" in newInteractable:
		interact_texrect.texture=icons.item
		interact_label.text="Pick up..."
	elif "personality" in newInteractable:
		interact_texrect.texture=icons.npc
		interact_label.text="Talk"
	fixed_position = Vector2(
	newInteractable.get_global_position().x - 30,
	newInteractable.get_global_position().y - 30
	)
	set_global_position(fixed_position)
	show()
