extends Node

signal scene_changed

signal ready_stage
signal pDisable
signal pEnable
signal plsStartDialogue
signal target_locked
signal change_stage
signal register_camera_limits
signal shake_camera
var def_scr_w = ProjectSettings.get("display/window/size/width")
var def_scr_h = ProjectSettings.get("display/window/size/height")

func _init() -> void:
  reset_video()
  return


#TODO: possibly de-hardcode?
const select = {
    "title"    : "res://scenes/TitleScreen.tscn",
    "game"     : "res://scenes/gui/Viewports.tscn",
    "settings" : "res://scenes/Settings.tscn",
    "controls" : "res://scenes/Controls.tscn",
    "filemenu" : "res://scenes/gui/SaveMenu.tscn",
    "savewiz"  : "res://scenes/gui/SaveWizard.tscn",
    "boot"     : "res://scenes/BootScrn.tscn"
}

func swap_stage(level : PackedScene) -> void:
  emit_signal("change_stage", level)
  return

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
  emit_signal("plsStartDialogue", diag, requester, overrideDefaultStart)
  return

func battle_started() -> void:
  emit_signal("fighting")
  return

func battle_over() -> void:
  emit_signal("fighting_over")
  return

func stage_ready(map : Resource) -> void:
  emit_signal("ready_stage", map)
  return

func pDisableInput() -> void:
  emit_signal("pDisable")
  return

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

func party_ready(who) -> void:
  emit_signal("target_locked", who)
  return

func registerCameraLimits(node : CameraLimits) -> void:
  emit_signal(
    "register_camera_limits",
    node.global_position,                     #TOP-LEFT
    node.global_position + node.shape.extents #BOTTOM-RIGHT
  )
  return
