extends AwareBase
class_name PlayerFollower

"""
var curvefollow : Curve2D
var followindex := 0
var followpoints
"""
var target

onready var animPlayer = $AnimationPlayer
onready var animTree   = $AnimationPlayer/AnimationTree
onready var animState  = animTree.get("parameters/playback")
onready var sprite     = $Sprite

signal moving

var following = null
"""
func _ready() -> void:
  if get_parent() is Party:
    get_parent().connect("playerPos_update", self, "add_snake_queue")
  return
"""
func _physics_process(_delta) -> void:
  animHndlr()
  moveState()
  return

func targetSet(pos: Vector2, spd: int) -> void:
  target = pos
  moveSpeed = spd
  return

func moveState() -> void:
  """
  if curvefollow: # if we even have anything to follow
    followpoints = curvefollow.get_baked_points() #let's get all points we can go to
    var target = followpoints[followindex] #let's follow the first point and go from there
    if position.distance_to(target) > 18: #wait for the player to get a bit far
      #vector math
      movedir = target - position
      motion = movedir.normalized() * moveSpeed
      motion = move_and_slide(motion, Vector2(0, 0))
    else:
      followindex += 1
      if followindex >= followpoints.size():
        followindex = 0
        curvefollow = null
        movedir = Vector2.ZERO
  """
  if target:
    if position.distance_to(target) > 18:
      movedir = target - position
      motion = movedir.normalized() * moveSpeed
      motion = move_and_slide(motion, Vector2(0, 0))
      emit_signal("moving", position, moveSpeed)
    else:
      movedir = Vector2.ZERO

  return
"""
func add_snake_queue(curve: Curve2D) -> void:
  curvefollow = curve
  return
"""
func animHndlr():
  animTree.set("parameters/run_Pose/blend_position", movedir)
  animTree.set("parameters/idle/blend_position", movedir)
  animTree.set("parameters/walk/blend_position", movedir)
  animTree.set("parameters/run/blend_position", movedir)
  if movedir != Vector2.ZERO:
    if moveSpeed > 65:
      animState.travel("run")
    else:
      animState.travel("walk")
  else:
    if moveSpeed > 65:
      animState.travel("run_Pose")
    else:
      animState.travel("idle")
  return

func setup() -> void:
  sprite.texture = lifeform.overworld
  return
