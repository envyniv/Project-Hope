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
  FileMan.connect("party_updated", self, "clean_party")
  party_upd()
  return

func party_upd() -> void:
  var temp = memberInfo.instance()
  temp.pointing = FileMan.data.lead
  vbox.add_child(temp)
  for Lifeform in FileMan.data.partyRes:
    temp = memberInfo.instance()
    temp.pointing = Lifeform
    vbox.add_child(temp)
    temp.button.add_to_group("menumore_buttons")
  return

func clean_party() -> void:
  for every in vbox.get_children():
    every.queue_free()
  party_upd()
  return
