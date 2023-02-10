extends Node2D

onready var interact = get_node("../Interact")

onready var player = $Sprite/AnimationPlayer
onready var sprite = $Sprite

func _ready() -> void:
  interact.connect("target_changed", self, "target_changed", [], CONNECT_DEFERRED)
  hide()
  return

func target_changed(newInteractable : Node) -> void:
  # If the target is null we're not interacting.
  if (newInteractable == null):
    return
