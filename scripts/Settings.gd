extends Node
# TODO: dehardcode?
onready var voice_select  = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/VoiceBloop
onready var language      = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Language
onready var music         = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Music
onready var sfx           = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/SFX
onready var mtrlabel      = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Master/Percentage
onready var mtr           = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Master
onready var muslabel      = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Music/Percentage
onready var sfxlabel      = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/SFX/Percentage
onready var modman        = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Modman
onready var scale         = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Scale
onready var controls      = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/Controls
onready var txtspd        = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/TextSpd
onready var txtspdlabel   = $Popup/ScrollContainer/HBoxContainer/VBoxContainer/TextSpd/Percentage
onready var popup         = $Popup

func _ready() -> void:
  for i in round(OS.get_screen_size().y / SceneManager.def_scr_h):
    scale.get_popup().add_item(str(i+1) + "x")
  scale.get_popup().connect("id_pressed", self, "_on_scale_change")
  was_set()
  for i in TranslationServer.get_loaded_locales():
    language.get_popup().add_item(TranslationServer.get_locale_name(i))
  language.get_popup().connect("id_pressed", self, "_on_Language_selected")
  txtspd.connect("value_changed", self, "chg_txtspd")
  popup.connect("popup_hide", self, "_on_Button_pressed")
  return

func was_set() -> void:
  if FileMan.settings.sfxvol:
    sfx.value = FileMan.settings.sfxvol
  if FileMan.settings.bgmvol:
    music.value = FileMan.settings.bgmvol
  if FileMan.settings.voice:
    voice_select.pressed = true
  if FileMan.settings.txtspd:
    txtspd.value = FileMan.settings.txtspd
  return

func _on_scale_change(value):
  FileMan.settings.scale=value+1
  SceneManager.reset_video()

func _on_Music_value_changed(value: float):
  muslabel.text = str(music.value*100)+"%"
  FileMan.settings.bgmvol = value
  muslabel.rect_position.x = (music.rect_position.x-music.rect_size.x) *- music.value
  muslabel.show()
  AudioServer.set_bus_volume_db(FileMan.bgmbus, linear2db(value))

func _on_SFX_value_changed(value: float):
  sfxlabel.text = str(sfx.value*100)+"%"
  FileMan.settings.sfxvol=value
  sfxlabel.rect_position.x=(sfx.rect_position.x-sfx.rect_size.x) *- sfx.value
  sfxlabel.show()
  AudioServer.set_bus_volume_db(FileMan.sfxbus, linear2db(value))

func _on_Language_selected(index):
  var id = language.get_popup().get_item_text(index)
  for i in TranslationServer.get_loaded_locales():
    if id == TranslationServer.get_locale_name(i):
      var selected=i
      TranslationServer.set_locale(i)
      FileMan.settings.lang=selected

func _on_VoiceBloop_toggled(i) -> void:
  FileMan.settings.voice=i
  return

func _on_Button_pressed() -> void:
  FileMan.dump2sets()

func _on_Controls_pressed() -> void:
  FileMan.dump2sets()
  SceneManager.change_scene("controls",0)
  return

func _on_Reset_Set_pressed() -> void:
  FileMan.reset_data()
  was_set()
  return

func chg_txtspd(value):
  FileMan.settings.txtspd = value
  txtspdlabel.rect_position.x = (txtspd.rect_position.x-txtspd.rect_size.x)*-txtspd.value*10
  if txtspd.value >= 0.1:
    txtspdlabel.text = TranslationServer.translate("setTxtSpdFast")
  elif txtspd.value >= 0.05:
    txtspdlabel.text = TranslationServer.translate("setTxtSpdNormal")
  elif txtspd.value >= 0.001:
    txtspdlabel.text = TranslationServer.translate("setTxtSpdSlow")


func _on_Master_value_changed(value: float):
  mtrlabel.text = str(mtr.value*100)+"%"
  FileMan.settings.mtrvol = value
  mtrlabel.rect_position.x = (mtr.rect_position.x-mtr.rect_size.x) *- mtr.value
  mtrlabel.show()
  AudioServer.set_bus_volume_db(FileMan.mtrbus, linear2db(value))
