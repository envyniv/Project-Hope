extends Control

onready var interact = get_node("../Interact")

var fixed_position : Vector2

func _ready():
  interact.connect("target_changed", self, "target_changed", [], CONNECT_DEFERRED)
  hide()

func target_changed(newInteractable : Node) -> void:
    # If the target is null we're not interacting.
    if (newInteractable == null):
        hide()
        return
    fixed_position = Vector2(
    newInteractable.get_global_position().x - 30,
    newInteractable.get_global_position().y - 30
    )
    show()
