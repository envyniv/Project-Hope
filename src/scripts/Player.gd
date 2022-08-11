
extends AwareBase
class_name Player

onready var animTree   = $AnimationPlayer/AnimationTree
onready var animState  = animTree.get("parameters/StateMachine/playback")
onready var sprite     = $Sprite
onready var sfx        = $AudioStreamPlayer

var target

export var sprintHoldTime : float = 2.25

signal moving

func _ready() -> void:
  if lifeform:
    sprite.texture = lifeform.overworld
  # warning-ignore:return_value_discarded
  SceneManager.connect("pDisable", self, "disable_input")
  # warning-ignore:return_value_discarded
  SceneManager.connect("pEnable", self, "enable_input")
  return

func _physics_process(_delta) -> void:
  animHndlr()
  moveState()
  return

func animHndlr() -> void:
  if movedir != Vector2.ZERO:
    animTree.set("parameters/TimeScale/scale", moveSpeed/walk)
    animTree.set("parameters/StateMachine/walk/blend_position", movedir)
    animTree.set("parameters/StateMachine/crouch/blend_position", movedir)
    animState.travel("walk")
    if moveSpeed > walk:
      animTree.set("parameters/StateMachine/run/blend_position", movedir)
      animState.travel("run")
  else:
    if moveSpeed > sprint:
      animState.travel("crouch")
    else:
      animState.travel("walk")
    animTree.set("parameters/TimeScale/scale", 0)
  return

func runState() -> void: #slingshot sprinting
  yield(get_tree().create_timer(sprintHoldTime), "timeout")
  if !(Input.is_action_pressed("sprint") && movedir == Vector2.ZERO):
    return
  moveSpeed = boost
  sfx.play()
  state = MOVE
  return

func moveState() -> void:  #actual movement
  motion = movedir.normalized() * moveSpeed
  # warning-ignore:return_value_discarded
  move_and_slide(motion, Vector2.ZERO)
  if movedir != Vector2.ZERO:
    var compare = Vector2.DOWN
    var difference = compare.angle_to(motion)
    $Interact.rotation_degrees = rad2deg(difference)
    emit_signal("moving", position, moveSpeed)
  return

func _unhandled_input(event):
  var kUP     = Input.is_action_pressed("ui_up")
  var kDOWN   = Input.is_action_pressed("ui_down")
  var kRIGHT  = Input.is_action_pressed("ui_right")
  var kLEFT   = Input.is_action_pressed("ui_left")
  movedir.x  = -int(kLEFT) + int(kRIGHT)
  movedir.y  = -int(kUP)   + int(kDOWN)
  if movedir != Vector2.ZERO:
    state = MOVE
    if Input.is_action_just_pressed("sprint"):
      moveSpeed = sprint
  else:
    if Input.is_action_just_pressed("sprint"):
      state = SPRINT
      runState()
    state = IDLE
    moveSpeed = walk
  return

func enable_input() -> void:
  set_process_unhandled_input(true)
  $Interact/CollisionShape2D.disabled = false
  return

func disable_input() -> void:
  set_process_unhandled_input(false)
  $Interact/CollisionShape2D.disabled = true
  return
