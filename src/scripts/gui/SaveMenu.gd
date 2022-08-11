extends Control

export(NodePath) var popup

export(PackedScene) var saveslot
onready var vbox  := $Panel/Saves/VBoxContainer
onready var nbut  := $Panel/Label/NewFile

func _ready() -> void:
  popup = get_node(popup)
  #warning-ignore:RETURN_VALUE_DISCARDED
  nbut.connect("pressed", self, "createNew")
  #warning-ignore:RETURN_VALUE_DISCARDED
  popup.connect("remove", self, "removeFile")
  #warning-ignore:RETURN_VALUE_DISCARDED
  popup.connect("copy", self, "update_list")
  #var details       = FileMan.return_saves_details()
  $Player.volume_db = linear2db(FileMan.settings.bgmvol)
  list_saves()
  return

func update_list() -> void:
  clean_list()
  list_saves()
  return

func clean_list() -> void:
  for i in vbox.get_children():
    i.queue_free()
  return

func list_saves() -> void:
  for i in FileMan.saves:
    var slot = saveslot.instance()
    vbox.add_child(slot)
    slot.pointing = i
    slot.name = i.name
    slot.texbut.connect("pressed", self, "_onSlotTexbut", [slot.pointing, slot.texbut.rect_global_position])
    slot = null
  if vbox.get_child_count():
    vbox.get_child(0).texbut.grab_focus()
  else:
    nbut.grab_focus()
  return

func createNew() -> void:
  nbut.hide()
  var slot = saveslot.instance()
  vbox.add_child(slot)
  slot.pointing = Save.new()
  slot.texbut.connect("pressed", self, "_onSlotTexbut", [slot.pointing, slot.texbut.rect_global_position])
  slot.texbut.grab_focus()
  return

func _onSlotTexbut(save, butpos) -> void:
  if save.name == Save.new().name:
    SceneManager.change_scene("savewiz", 0)
  else:
    popup.pointing = save
    popup.rect_position = butpos
    popup.popup()
  return

func removeFile(name) -> void:
  for i in vbox.get_children():
    if i.name == name:
      i.queue_free()
  if vbox.get_child_count():
    vbox.get_child(0).texbut.grab_focus()
  else:
    nbut.grab_focus()
  return
