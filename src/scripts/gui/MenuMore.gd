extends Control

signal exit_menumore

var partymemMenu = "res://scenes/gui/MenuMoreMemberContainer.tscn"

func _input(_event : InputEvent) -> void:
  if Input.is_action_pressed("ui_cancel"):
    emit_signal("exit_menumore")
    release_focus()
  return

func _ready() -> void:
  party_upd()
  return

func party_upd() -> void:
  for i in FileMan.data.party:
    var temp = load(partymemMenu).instance()
    temp.who = i
    $VBoxContainer.add_child(temp)
  return
