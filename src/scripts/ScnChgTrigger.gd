tool
extends Area2D

var stage: PackedScene
var where: Vector2
var contact: bool

func _ready() -> void:
  if contact:
    connect("body_entered", self, "_interact")
  return

func can_interact(interactParent : Node) -> bool:
    return interactParent is Player

func _interact(_interactParent : Node) -> void:
  FileMan.data.position = where
  SceneManager.swap_stage(stage)
  return

func _set(prop: String, val) -> bool:
  match prop:
    "targetScene":
      stage = val
    "onTouch":
      contact = val
    "atPosition":
      where = val
    _:
      return false
  property_list_changed_notify()
  return true

func _get(prop: String):
  match prop:
    "targetScene":
      return stage
    "onTouch":
      return contact
    "atPosition":
      return where
  return null

func _get_property_list() -> Array:
  var props = []
  props.append({
  "name":"targetScene",
  "type" : typeof(PackedScene),
  })
  if stage != null:
    props.append({         # NOTE: IF THIS IS ENABLED, THE PLAYER WILL NOT
      "name" : "onTouch",  #       NEED TO INTERACT
      "type" : TYPE_BOOL
    })
    props.append({
    "name":"atPosition",
    "type" : TYPE_VECTOR2,
    })
  return props
