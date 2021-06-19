extends Node

signal scene_changed()
onready var animation_player=$CanvasLayer/AnimationPlayer
onready var color_rect=$CanvasLayer/Control/ColorRect
signal target_locked
signal convo_y
signal convo_n
signal fighting
signal fighting_over
signal vending
signal left_vending
signal ready_stage
signal pDisable
signal pEnable

const select = {
    "title"    : "res://scenes/TitleScreen.tscn",
    "game"     : "res://scenes/gui/Viewports.tscn",
    "settings" : "res://scenes/Settings.tscn",
    "controls" : "res://scenes/Controls.tscn"
}

const stage={
  "meteora"   : "res://scenes/stage/Meteora.tscn",
  "battle"    : "res://scenes/stage/BattleWorld.tscn",
  "map"       : "res://scenes/stage/worldmap.tscn",
  "utopia"    : "",
  "fantasia"  : "",
  "tyche"     : "",
  "koine"     : "",
  "eirene"    : "",
  "xenos"     : "",
  "oneiros"   : "",
  "kassandra" : "",
  "basileus"  : "",
  "philomela" : "",
  "erimos"    : "",
  "hypnos"    : "",
  "nyx"       : "",
}

func change_scene(chosen, delay=0):
    var path
    if chosen in select:
        path = select[chosen]
    else:
        print(select[chosen], "not found")
    transition_start(delay)
    yield(animation_player, "animation_finished")
  # warning-ignore:return_value_discarded
    get_tree().change_scene(path)
    transition_end()
    yield(animation_player, "animation_finished")
    pass

func transition_start(delay=0):
    yield(get_tree().create_timer(delay),"timeout")
    animation_player.play("fade")

func transition_end():
    animation_player.play_backwards("fade")
    emit_signal("scene_changed")
    pass

func tactical_lock_on(target):
  emit_signal("target_locked", target)

func vending_up():
  emit_signal("vending")

func vending_left():
  emit_signal("left_vending")

func convo_on():
  emit_signal("convo_y")

func convo_off():
  emit_signal("convo_n")

func battle_started():
  emit_signal("fighting")

func battle_over():
  emit_signal("fighting_over")

func stage_ready(name):
  emit_signal("ready_stage", name)

func pDisableInput():
  emit_signal("pDisable")

func pEnableInput():
  emit_signal("pEnable")
