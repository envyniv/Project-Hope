extends Node
onready var voice_select  = $ColorRect/ScrollContainer/VBoxContainer/VoiceBloop
onready var language      = $ColorRect/ScrollContainer/VBoxContainer/Language
onready var music         = $ColorRect/ScrollContainer/VBoxContainer/Music
onready var sfx           = $ColorRect/ScrollContainer/VBoxContainer/SFX
onready var muslabel      = $ColorRect/ScrollContainer/VBoxContainer/Music/Percentage
onready var sfxlabel      = $ColorRect/ScrollContainer/VBoxContainer/SFX/Percentage
onready var modman        = $ColorRect/ScrollContainer/VBoxContainer/Modman
onready var windowLabel   = $ColorRect/Label
onready var controls      = $ColorRect/ScrollContainer/VBoxContainer/Controls
onready var tip           = $ColorRect/Label/TipLabel
onready var reset         = $ColorRect/Label/Reset_Set
onready var menubutton    = $ColorRect/Label/Button

func _ready():
#  for i in FileMan.mods:
#    var iprocess = i.get_basename()
#    if iprocess != ".":
#      print(iprocess)
#      modman.get_popup().add_item(iprocess)
  for i in TranslationServer.get_loaded_locales():
    language.get_popup().add_item(TranslationServer.get_locale_name(i))
  language.get_popup().connect("id_pressed", self, "_on_Language_selected")
  was_set()

func was_set():
  if FileMan.settings.sfxvol:
    sfx.value=FileMan.settings.sfxvol
  if FileMan.settings.bgmvol:
    music.value=FileMan.settings.bgmvol
#  if FileMan.data.lang!=null:
#    language.value
  if FileMan.settings.voice:
    voice_select.pressed = true

func _process(_delta):
    muslabel.text=str(music.value*100)+"%"
    sfxlabel.text=str(sfx.value*100)+"%"

func _on_Music_value_changed(value):
  FileMan.settings.bgmvol=value

func _on_SFX_value_changed(value):
  FileMan.settings.sfxvol=value

func _on_Language_selected(index):
  var id = language.get_popup().get_item_text(index)
  for i in TranslationServer.get_loaded_locales():
    if id==TranslationServer.get_locale_name(i):
      var selected=i
      TranslationServer.set_locale(i)
      FileMan.settings.lang=selected

func _on_VoiceBloop_toggled(i):
  FileMan.settings.voice=i
  #FileMan.data["settings"]["voice"]=i

func _on_Button_pressed():
    SceneManager.change_scene("title",0)
    FileMan.dump2sets()

func _on_Controls_pressed():
    SceneManager.change_scene("controls",0)

func _on_Reset_Set_pressed():
    FileMan.reset_data()
    was_set()
