extends NinePatchRect

onready var savename:Node = $SaveName
onready var location:Node = $LocationName
onready var playtime:Node = $Playtime
onready var preview :Node = $TextureRect
onready var texbut  :Node = $TextureButton
onready var delbut  :Node = $DeleteButton
onready var cpbut   :Node = $CopyButton
var assignedpath

func _ready() -> void:
  #warning-ignore:return_value_discarded
  texbut.connect("pressed", self, "_texbut")
  #warning-ignore:return_value_discarded
  delbut.connect("pressed", self, "_delbut")
  delbut.hide()
  return

func setup(namesave, savelocation, amountTime, screenshot, path=null) -> void:
  var img = Image.new()
  var tex = ImageTexture.new()
  savename.text=namesave.to_upper()
  location.text=savelocation.capitalize()
  #playtime.text=str(round(amountTime/3600))+TranslationServer.translate("menuHours")+", "+str(round(amountTime/60))+TranslationServer.translate("menuMins")
  if round(amountTime/60) < 10:
    playtime.text=str(round(amountTime/3600),":0",round(amountTime/60))
  else:
    playtime.text=str(round(amountTime/3600),":",round(amountTime/60))
  if screenshot!=null:
    img.create_from_data(360, 240, false, 5, screenshot)
    img.flip_y()
    tex.create_from_image(img)
    delbut.show()
    cpbut.show()
    preview.show()
    preview.texture=tex
    $GPanel.show()
  else:
    preview.hide()
    delbut.hide()
    $GPanel.hide()
    cpbut.hide()
  if path != null:
    assignedpath = path
  return

func _texbut() -> void:
  var f=File.new()
  if f.file_exists(assignedpath):
    FileMan.load_game()
    SceneManager.change_scene("game",0)
  else:
    SceneManager.change_scene("savewiz",0)
  FileMan.slotselected = assignedpath
  return

func _delbut() -> void:
  setup("Empty", "", 0, null, assignedpath)
  FileMan.slotselected = assignedpath
  FileMan.delete_save()
  return

func _cpbut() -> void:
  return
