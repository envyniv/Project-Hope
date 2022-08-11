tool
extends KinematicBody2D
class_name AwareBase
var lifeform

var movedir   := Vector2.ZERO
var moveSpeed : float
var walk      = 65
var sprint    = 135
var boost     = 165
var motion

enum { MOVE, IDLE, SPRINT }
var state

"""
func _physics_process(_delta):
  if movedir != Vector2.ZERO:
    #if moveSpeed > 65:
    #  state = SPRINT
    #else:
      state = MOVE
  else:
    state = IDLE
"""

func moveState():  #movement
  motion = movedir.normalized() * moveSpeed
# warning-ignore:return_value_discarded
  move_and_slide(motion, Vector2(0, 0))

func _set(prop: String, val) -> bool:
  match prop:
    "EntityResource":
      lifeform = val
    _:
      return false
  property_list_changed_notify()
  return true

func _get(prop: String):
  match prop:
    "EntityResource":
      return lifeform
  return null

func _get_property_list() -> Array:
  var props := []
  props.append({
    "name": "EntityResource",
    "type" : typeof(Resource),
    "hint" : PROPERTY_HINT_RESOURCE_TYPE,
    "hint_string" : ""
  })
  return props
