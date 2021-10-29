extends Node

onready var view         = $Game/Viewport
onready var diagbox      = $Game/DiagBox
#onready var battlelayout = $Game/BattleStatLayout
onready var cam          = $Game/Viewport/Camera2D

func _ready():
  #battlelayout.hide()
# warning-ignore:return_value_discarded
#  SceneManager.connect("fighting", self, "show_battle_gui")
# warning-ignore:return_value_discarded
#  SceneManager.connect("fighting_over", self, "hide_battle_gui")
  #SceneManager.connect("fighting", self, "show_battle_gui")
  #SceneManager.connect("fighting_over", self, "hide_battle_gui")
  #cam.connect("set_limits", self, set_cam_limit())
  SceneManager.connect("plsChangeLeveliBegYou", self, "change_level")
  FileMan.curtime=OS.get_unix_time()
  SceneManager.change_level_relay(FileMan.data.location)

#func show_battle_gui():
#  battlelayout.show()

#func hide_battle_gui():
#  battlelayout.hide()

func _input(_event):
  var MENU=Input.is_action_just_pressed("ui_end")
  if MENU:
    set_process_input(false)
    $Game/Control.show()
    SceneManager.pDisableInput()

func change_level(level): # use SceneManager.change_level_relay(levelrelay)
  if view.get_children().size() == 2:
    var current_stage = view.get_child(1)
    current_stage.queue_free()
  view.add_child(load(level).instance())
