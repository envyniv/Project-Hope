extends AwareBase
class_name PlayerFollower

var curvefollow : Curve2D
var followindex = 0
var followpoints

onready var animPlayer = $AnimationPlayer
onready var animTree   = $AnimationPlayer/AnimationTree
onready var animState  = animTree.get("parameters/playback")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  setup()
  return

func _physics_process(_delta) -> void:
  moveState()
  return

func moveState() -> void:
  if followpoints:
    followpoints = curvefollow.get_baked_points()
    var target = followpoints[followindex]
    if position.distance_to(target) < 16:
      followindex += 1
      if followindex >= followpoints.size():
        followindex = 0
        curvefollow = null
        movedir = Vector2.ZERO
      target = followpoints[followindex]
      moveSpeed = 65
    else: # this else was put to stop the walking animation from playing every frame, but causes janky motion
      movedir = target - position
      var multiplier = position.distance_to(target)
      motion = movedir.normalized() * multiplier * 6
      motion = move_and_slide(motion, Vector2(0, 0))
      moveSpeed = 130
  return

func add_snake_queue(curve:Curve2D) -> void:
  curvefollow = curve
  return
  
func animHndlr():
  animTree.set("parameters/run_Pose/blend_position", movedir)
  animTree.set("parameters/idle/blend_position", movedir)
  animTree.set("parameters/walk/blend_position", movedir)
  animTree.set("parameters/run/blend_position", movedir)
  if state == THINK:
    animPlayer.play("think")
  elif state == STUN:
    print("player stunned")
  elif movedir != Vector2.ZERO:
    if moveSpeed > 65:
      animState.travel("run")
    else:
      animState.travel("walk")
  else:
    if moveSpeed > 65:
      animState.travel("run_Pose")
    else:
      animState.travel("idle")

func setup() -> void:
  return
