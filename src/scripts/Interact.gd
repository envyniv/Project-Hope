extends Area2D

onready var parent = get_parent()
signal target_changed(newInteractable)
var target : Node

func _ready() -> void:
  connect("body_entered", self, "_on_body_entered")
  connect("body_exited", self, "_on_body_exited")

  #connect("area_entered", self, "_on_area_entered")
  #connect("area_exited", self, "_on_area_exited")
  return

func _process(_delta):
  if (target != null && Input.is_action_just_pressed("ui_accept")):
    if (target.has_method("_interact")):
      target._interact(self)

func _on_body_entered(body):
  var canInteract := false

  if (body.has_method("can_interact")):
    canInteract = body.can_interact(parent)

  if !canInteract:
    return

  target = body
  emit_signal("target_changed", target)

func _on_body_exited(body):
  if (body == target):
    target = null
    emit_signal("target_changed", null)

"""
func _on_area_entered(body):
  var canInteract := false

  if (body.has_method("can_interact")):
    canInteract = body.can_interact(parent)

  if !canInteract:
    return

  target = body
  emit_signal("target_changed", target)

func _on_area_exited(body):
  if (body == target):
    target = null
    emit_signal("target_changed", null)
"""
