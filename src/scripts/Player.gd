extends AwareBase
class_name Player

onready var animPlayer = $AnimationPlayer
onready var animTree =   $AnimationPlayer/AnimationTree
onready var animState =  animTree.get("parameters/playback")
onready var sprite =     $Sprite
onready var hitbox =     $HitBox
onready var damagebox =  $DamageBox

func _ready():
  position=FileMan.data.position
  facing=look.DOWN
  value_check()
  match facing:
    look.UP:
      animPlayer.play("idle_Up")
    look.RIGHT:
      animPlayer.play("idle_Right")
    look.DOWN:
      animPlayer.play("idle_Down")
    look.LEFT:
      animPlayer.play("idle_Left")
  animTree.active = true
  SceneManager.tactical_lock_on(self)
    # warning-ignore:return_value_discarded
  SceneManager.connect("convo_y", self, "disable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("convo_n", self, "enable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("fighting", self, "enable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("fighting_over", self, "disable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("vending", self, "disable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("left_vending", self, "enable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("pDisable", self, "disable_input")
    # warning-ignore:return_value_discarded
  SceneManager.connect("pEnable", self, "enable_input")
    # warning-ignore:return_value_discarded
  hitbox.connect("area_entered", self, "on_hitbox")

func _exit_tree() -> void:
  camera_stop_follow()
  return

func on_hitbox(area) -> void:
  if area.get_parent() != hitbox.get_parent():
    calc_damage()
  return

func _physics_process(_delta) -> void:
  animHndlr()
  match state:
    MOVE:
      moveState()
    ATKING:
      atkState()
    DODGE:
      dodgeState()
    THINK:
      thinkState()
    STUN:
      stunState()
    KO:
      downState()
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
