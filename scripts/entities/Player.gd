tool
class_name Player extends VesselBase
export(NodePath) var interact_raycast

func _ready() -> void:
  if Engine.editor_hint:
    return
  # party = FileMan.data.partyRes
  if SceneManager.player_pos:
    position = SceneManager.player_pos
    SceneManager.player_pos = null
  interact_raycast = get_node(interact_raycast)
  # warning-ignore:return_value_discarded
  SceneManager.connect("pDisable", self, "disable_input")
  # warning-ignore:return_value_discarded
  SceneManager.connect("pEnable", self, "enable_input")
  borrowCamera()
  SceneManager.playerReady(self)
  return

func _unhandled_input(_event):
  var kUP     = Input.is_action_pressed("ui_up")
  var kDOWN   = Input.is_action_pressed("ui_down")
  var kRIGHT  = Input.is_action_pressed("ui_right")
  var kLEFT   = Input.is_action_pressed("ui_left")
  var kRUN    = Input.is_action_pressed("sprint")
  movedir.x  = -int(kLEFT) + int(kRIGHT)
  movedir.y  = -int(kUP)   + int(kDOWN)
  if kRUN:
    state = SPRINT
  elif movedir != Vector2.ZERO:
    state = MOVE
    if Input.is_action_just_pressed("sprint"):
      move_spd = sprint
    var compare = Vector2.DOWN
    var difference = compare.angle_to(movedir)
    interact_raycast.rotation_degrees = rad2deg(difference)
  else:
    state = IDLE
    move_spd = walk
  return

func enable_input() -> void:
  set_process_unhandled_input(true)
  interact_raycast.disabled = false
  return

func disable_input() -> void:
  set_process_unhandled_input(false)
  interact_raycast.disabled = true
  return

