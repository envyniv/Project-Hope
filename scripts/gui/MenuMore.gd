extends Control

onready var vbox = $VBoxContainer

signal exit_menumore

export(PackedScene) var memberInfo

func _input(_event : InputEvent) -> void:
  if Input.is_action_pressed("ui_cancel"):
    emit_signal("exit_menumore")
    release_focus()
  return

func _ready() -> void:
  #warning-ignore:RETURN_VALUE_DISCARDED
  SceneManager.connect("ready_player", self, "party_upd")
  return

func party_upd(whose: Player) -> void:
  clean_party()
  var temp = memberInfo.instance()
  temp.pointing = whose.lifeform
  vbox.add_child(temp)
  for member in whose.party:
    temp = memberInfo.instance()
    temp.pointing = member
    vbox.add_child(temp)
    temp.button.add_to_group("menumore_buttons")
  return

func clean_party() -> void:
  for child in vbox.get_children():
    child.queue_free()
  return
