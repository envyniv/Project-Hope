extends Node
onready var voice_select  = $ColorRect/ScrollContainer/VBoxContainer/VoiceBloop
onready var language      = $ColorRect/ScrollContainer/VBoxContainer/Language
onready var music         = $ColorRect/ScrollContainer/VBoxContainer/Music
onready var sfx           = $ColorRect/ScrollContainer/VBoxContainer/SFX
onready var muslabel      = $ColorRect/ScrollContainer/VBoxContainer/Music/Percentage
onready var sfxlabel      = $ColorRect/ScrollContainer/VBoxContainer/SFX/Percentage
onready var confirmdialog = $ColorRect/Label/Reset_Set/ConfirmationDialog
onready var modman        = $ColorRect/ScrollContainer/VBoxContainer/Modman

var langfile   = "res://scripts/diag/lang.json"

func _ready():
  var file       = File.new();
  file.open(langfile, File.READ)
  var text       = file.get_as_text()
  var langlist   = parse_json(text)
  file.close()
  for i in langlist:
    #print(langlist[i]["dir"])
    language.get_popup().add_item(i)
  language.get_popup().connect("id_pressed", self, "_on_Language_selected")
  for i in FileMan.mods:
    var iprocess = i.get_basename()
    if iprocess != ".":
      print(iprocess)
      modman.get_popup().add_item(iprocess)
  was_set()

func was_set():
  if FileMan.data.sfxvol != null:
    sfx.value=FileMan.data.sfxvol
  if FileMan.data.bgmvol != null:
    music.value=FileMan.data.bgmvol
#  if FileMan.data.lang!=null:
#    language.value
  #if FileMan.data["settings"].has("voice"):
  #  voice_select=(FileMan.data["settings"]["voice"])
  #if FileMan.data["settings"].has("lang"):
  #  language.get_popup().selected=(FileMan.data["settings"]["lang"])

func _process(_delta):
    muslabel.text=str(music.value*100)+"%"
    sfxlabel.text=str(sfx.value*100)+"%"

func _on_Music_value_changed(value):
  FileMan.data.bgmvol=value
  #FileMan.data["settings"]["bgmvol"]=value


func _on_SFX_value_changed(value):
  FileMan.data.sfxvol=value
  #FileMan.data["settings"]["sfxvol"]=value

func _on_Language_selected(index):
  var file       = File.new();
  file.open(langfile, File.READ)
  var text       = file.get_as_text()
  var langlist   = parse_json(text)
  file.close()
  var id = language.get_popup().get_item_text(index)
  var selected = langlist[id]["dir"]
  FileMan.data.lang=selected
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
