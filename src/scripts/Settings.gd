extends Node
onready var voice_select  = $ColorRect/ScrollContainer/VBoxContainer/VoiceBloop
onready var language      = $ColorRect/ScrollContainer/VBoxContainer/Language
onready var music         = $ColorRect/ScrollContainer/VBoxContainer/Music
onready var sfx           = $ColorRect/ScrollContainer/VBoxContainer/SFX
onready var muslabel      = $ColorRect/ScrollContainer/VBoxContainer/Music/Percentage
onready var sfxlabel      = $ColorRect/ScrollContainer/VBoxContainer/SFX/Percentage
onready var confirmdialog = $ColorRect/Label/Reset_Set/ConfirmationDialog
onready var modman        = $ColorRect/ScrollContainer/VBoxContainer/Modman
onready var windowLabel   = $ColorRect/Label
onready var controls      = $ColorRect/ScrollContainer/VBoxContainer/Controls
onready var tip           = $ColorRect/Label/TipLabel
onready var reset         = $ColorRect/Label/Reset_Set
onready var menubutton    = $ColorRect/Label/Button

func _ready():
  var file       = File.new();
  file.open(FileMan.langfile, File.READ)
  var text       = file.get_as_text()
  var langlist   = parse_json(text)
  file.close()
  for i in langlist:
    #print(langlist[i]["dir"])
    language.get_popup().add_item(i)
  language.get_popup().connect("id_pressed", self, "_on_Language_selected")
  update_text()
#  for i in FileMan.mods:
#    var iprocess = i.get_basename()
#    if iprocess != ".":
#      print(iprocess)
#      modman.get_popup().add_item(iprocess)
  was_set()

func was_set():
  if FileMan.data.sfxvol:
    sfx.value=FileMan.data.sfxvol
  if FileMan.data.bgmvol:
    music.value=FileMan.data.bgmvol
#  if FileMan.data.lang!=null:
#    language.value
  if FileMan.data.voice:
    voice_select.pressed = true
  #if FileMan.data["settings"].has("lang"):
  #  language.get_popup().selected=(FileMan.data["settings"]["lang"])

func _process(_delta):
    muslabel.text=str(music.value*100)+"%"
    sfxlabel.text=str(sfx.value*100)+"%"

func _on_Music_value_changed(value):
  FileMan.data.bgmvol=value
  #FileMan.data["settings"]["bgmvol"]=value

func update_text():
  windowLabel.text = FileMan.returnTranslation(windowLabel.text)
  voice_select.text = FileMan.returnTranslation(voice_select.text)
  language.text = FileMan.returnTranslation(language.text)
  modman.text = FileMan.returnTranslation(modman.text)
  sfx.get_node("Label").text = FileMan.returnTranslation(sfx.get_node("Label").text)
  music.get_node("Label").text = FileMan.returnTranslation(music.get_node("Label").text)
  controls.text = FileMan.returnTranslation(controls.text)
  tip.text = FileMan.returnTranslation(tip.text)
  controls.hint_tooltip = FileMan.returnTranslation(controls.hint_tooltip)
  reset.hint_tooltip = FileMan.returnTranslation(reset.hint_tooltip)
  menubutton.hint_tooltip = FileMan.returnTranslation(menubutton.hint_tooltip)

func _on_SFX_value_changed(value):
  FileMan.data.sfxvol=value
  #FileMan.data["settings"]["sfxvol"]=value

func _on_Language_selected(index):
  var file       = File.new();
  file.open(FileMan.langfile, File.READ)
  var text       = file.get_as_text()
  var langlist   = parse_json(text)
  file.close()
  var id = language.get_popup().get_item_text(index)
  var selected = langlist[id]["dir"]
  FileMan.data.lang=selected
  #update_text()
  #FileMan.data["settings"]["lang"]=selected

func _on_VoiceBloop_toggled(i):
  FileMan.data.voice=i
  #FileMan.data["settings"]["voice"]=i

func _on_Button_pressed():
    SceneManager.change_scene("title",0)
    FileMan.save_game()

func _on_Controls_pressed():
    SceneManager.change_scene("controls",0)

func _on_Reset_Set_pressed():
    FileMan.reset_data()
    was_set()
