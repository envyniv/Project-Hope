extends PopupPanel

export(NodePath) var loadBut
export(NodePath) var deleteBut
export(NodePath) var copyBut
export(NodePath) var modsPanel
export(NodePath) var more_ModsSep

var checkboxes := []

var pointing : Resource setget populate

signal remove
signal copy

func populate(set) -> void: #show what mods are enabled
  for i in set.mods:
    var desiredcheck = checkboxes.find(i.name)
    if desiredcheck:
      checkboxes[desiredcheck].set_pressed_no_signal(true)
  pointing = set
  #loadBut.text = pointing.resource_path.get_file()
  return

func _ready() -> void:
  loadBut      = get_node(loadBut)
  deleteBut    = get_node(deleteBut)
  copyBut      = get_node(copyBut)
  modsPanel    = get_node(modsPanel)
  more_ModsSep = get_node(more_ModsSep)

  loadBut.connect("pressed", self, "_onLoadBut")
  deleteBut.connect("pressed", self, "_onDelBut")
  copyBut.connect("pressed", self, "_onCopyBut")

  populate_mod_list()
  return

func populate_mod_list() -> void:
  var modsList = modsPanel.get_node("List")
  if FileMan.mods.empty():
    modsPanel.hide()
    more_ModsSep.hide()
    rect_size = rect_min_size
  else:
    var modVBox = VBoxContainer.new()
    modsList.add_child(modVBox)
    for i in FileMan.mods:
      var modcheck = ModCheckBox.new()
      modVBox.add_child(modcheck)
      modcheck.pointing = i
      modcheck.connect("toggled", self, "_onModCheck", [modcheck.pointing])
      checkboxes.append(modcheck)
      modcheck = null
  return

func _onModCheck(toggled, mod) -> void:
  FileMan.load_game(pointing)
  if toggled:
    pointing.mods.append(mod)
  else:
    pointing.mods.erase(mod)
  FileMan.save_game()
  return

func _onDelBut() -> void:
  emit_signal("remove", pointing.name)
  FileMan.delete_save(pointing)
  release_focus()
  hide()
  return

func _onCopyBut() -> void:
  FileMan.load_game(pointing)
  FileMan.copy_save()
  release_focus()
  hide()
  emit_signal("copy")
  return

func _onLoadBut() -> void:
  FileMan.load_game(pointing)
  SceneManager.change_scene("game",0)
  return
