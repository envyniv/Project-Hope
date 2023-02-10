extends Node

# Singleton node that provides methods for game objects to use, most consisting of signal relays.


signal scene_changed
signal change_stage
signal ready_stage
signal ready_player

signal pDisable
signal pEnable

signal startDialogue

signal target_locked
signal camera_returned
signal register_camera_limits
signal shake_camera

var def_scr_w = ProjectSettings.get("display/window/size/width")
var def_scr_h = ProjectSettings.get("display/window/size/height")

# temporary party members storage (for stage switching)
var player_party := []

# temporary player position storage (for stage switching)
var player_pos = null

func _init() -> void:
  reset_video()
  return

const select = {
    "title"    : "res://scenes/menu/TitleScreen.tscn",
    "game"     : "res://scenes/game/gui/Viewports.tscn",
    "controls" : "res://scenes/menu/Controls.tscn",
    "filemenu" : "res://scenes/menu/SaveMenu.tscn",
    "savewiz"  : "res://scenes/menu/SaveWizard.tscn",
    "boot"     : "res://scenes/BootScrn.tscn"
}


# Relays a signal to make the game change scenes.
func swap_stage(level : PackedScene) -> void:
  emit_signal("change_stage", level)
  return

# Relays a signal to make the camera shake.
func camera_shake(duration: float, frequency: float, amplitude: float) -> void:
  emit_signal("shake_camera", duration, frequency, amplitude)
  return

func change_scene(chosen, _delay=0) -> void:
    var path
    if chosen in select:
      path = select[chosen]
    else:
      print(select[chosen], "not found")
    #yield(animation_player, "animation_finished")
  # warning-ignore:return_value_discarded
    get_tree().change_scene(path)
    emit_signal("scene_changed")
    #yield(animation_player, "animation_finished")
    return

func start_convo(diag: Resource, requester: Node, overrideDefaultStart := "") -> void:
  emit_signal("startDialogue", diag, requester, overrideDefaultStart)
  return

func battle_started() -> void:
  emit_signal("fighting")
  return

func battle_over() -> void:
  emit_signal("fighting_over")
  return

# emits a signal with the player so all GUI nodes can set up accordingly
func playerReady(whom) -> void:
  emit_signal("ready_player", whom)
  return

# Disables player input, for enabling, see _pEnableInput_
func pDisableInput() -> void:
  emit_signal("pDisable")
  return

# Disables player input, for disabling, see _pDisableInput_
func pEnableInput() -> void:
  emit_signal("pEnable")
  return

func reset_video() -> void:
  OS.set_window_size(
    Vector2(
      def_scr_w * FileMan.settings.scale,
      def_scr_h * FileMan.settings.scale
    )
  )
  OS.center_window()
  return


#This function sets who the camera is tracking.
func borrowCamera(who) -> void:
  emit_signal("target_locked", who)
  return

func returnCamera() -> void:
  #warning-ignore: RETURN_VALUE_DISCARDED
  emit_signal("camera_returned")
  return

func registerCameraLimits(node) -> void:
  emit_signal(
    "register_camera_limits",
    node.rect_global_position, #TOP-LEFT
    node.rect_global_position + node.rect_size  #BOTTOM-RIGHT
  )
  return
