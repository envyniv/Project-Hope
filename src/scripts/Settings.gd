extends Node
onready var voice_select  = $ColorRect/ScrollContainer/VBoxContainer/VoiceBloop
onready var language      = $ColorRect/ScrollContainer/VBoxContainer/Language
onready var music         = $ColorRect/ScrollContainer/VBoxContainer/Music
onready var sfx           = $ColorRect/ScrollContainer/VBoxContainer/SFX
onready var muslabel      = $ColorRect/ScrollContainer/VBoxContainer/Music/Percentage
onready var sfxlabel      = $ColorRect/ScrollContainer/VBoxContainer/SFX/Percentage
onready var modman        = $ColorRect/ScrollContainer/VBoxContainer/Modman
onready var scale         = $ColorRect/ScrollContainer/VBoxContainer/Scale
onready var windowLabel   = $ColorRect/Label
onready var controls      = $ColorRect/ScrollContainer/VBoxContainer/Controls
onready var tip           = $ColorRect/Label/TipLabel
onready var reset         = $ColorRect/Label/Reset_Set
onready var menubutton    = $ColorRect/Label/Button
onready var player        = $"music-loop"
onready var txtspd        = $ColorRect/ScrollContainer/VBoxContainer/TextSpd
onready var txtspdlabel   = $ColorRect/ScrollContainer/VBoxContainer/TextSpd/Percentage

func _ready():
  for i in round(OS.get_screen_size().y/SceneManager.def_scr_h):
    scale.get_popup().add_item(str(i+1) + "x")
  scale.get_popup().connect("id_pressed", self, "_on_scale_change")
  was_set()
  for i in TranslationServer.get_loaded_locales():
    language.get_popup().add_item(TranslationServer.get_locale_name(i))
  language.get_popup().connect("id_pressed", self, "_on_Language_selected")
  player.volume_db=linear2db(FileMan.settings.bgmvol)
  player.stream=load("res://sounds/fx/settings_start.ogg")
  player.play()
  yield(player, "finished")
  player.stop()
  player.stream=load("res://sounds/music/settings_loop.ogg")
  player.play()
  txtspd.connect("value_changed", self, "chg_txtspd")

#  for i in FileMan.mods:
#    var iprocess = i.get_basename()
#    if iprocess != ".":
#      print(iprocess)
#      modman.get_popup().add_item(iprocess)


func was_set():
  if FileMan.settings.sfxvol:
    sfx.value = FileMan.settings.sfxvol
  if FileMan.settings.bgmvol:
    music.value = FileMan.settings.bgmvol
#  if FileMan.data.lang!=null:
#    language.value
  if FileMan.settings.voice:
    voice_select.pressed = true
  if FileMan.settings.txtspd:
    txtspd.value = FileMan.settings.txtspd
  #if FileMan.settings.scale:
    #scale.get_popup() = FileMan.settings.scale

func _on_scale_change(value):
  FileMan.settings.scale=value+1
  SceneManager.reset_video()

func _on_Music_value_changed(value):
  muslabel.text=str(music.value*100)+"%"
  FileMan.settings.bgmvol=value
  player.volume_db=linear2db(FileMan.settings.bgmvol)
  muslabel.rect_position.x=(music.rect_position.x-music.rect_size.x)*-music.value
  muslabel.show()

func _on_SFX_value_changed(value):
  sfxlabel.text=str(sfx.value*100)+"%"
  FileMan.settings.sfxvol=value
  sfxlabel.rect_position.x=(sfx.rect_position.x-sfx.rect_size.x)*-sfx.value
  sfxlabel.show()

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
  FileMan.dump2sets()
  player.stop()
  player.stream=load("res://sounds/fx/settings_end.ogg")
  player.play()
  yield(player, "finished")
  SceneManager.change_scene("title",0)

func _on_Controls_pressed():
    FileMan.dump2sets()
    SceneManager.change_scene("controls",0)


func _on_Reset_Set_pressed():
    FileMan.reset_data()
    was_set()
    
func chg_txtspd(value):
  FileMan.settings.txtspd=value
  txtspdlabel.rect_position.x=(txtspd.rect_position.x-txtspd.rect_size.x)*-txtspd.value*10
  if txtspd.value >= 0.1:
    txtspdlabel.text=TranslationServer.translate("setTxtSpdFast")
  elif txtspd.value >= 0.05:
    txtspdlabel.text=TranslationServer.translate("setTxtSpdNormal")
  elif txtspd.value >= 0.001:
    txtspdlabel.text=TranslationServer.translate("setTxtSpdSlow")
