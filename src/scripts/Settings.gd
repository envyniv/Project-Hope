extends Node
onready var voice_select=$ColorRect/ScrollContainer/VBoxContainer/VoiceBloop
onready var language=$ColorRect/ScrollContainer/VBoxContainer/Language
onready var music=$ColorRect/ScrollContainer/VBoxContainer/Music
onready var sfx=$ColorRect/ScrollContainer/VBoxContainer/SFX
onready var muslabel=$ColorRect/ScrollContainer/VBoxContainer/Music/Percentage
onready var sfxlabel=$ColorRect/ScrollContainer/VBoxContainer/SFX/Percentage
onready var confirmdialog=$ColorRect/Label/Reset_Set/ConfirmationDialog

func _ready():
	voice_select.add_item("Bloop")
	voice_select.add_item("None")
	# TODO: replace with system that parses through languages in
	#       scripts/dialogue/[language-name]/[lang-name].json
	language.add_item("English")
	language.add_item("French")
	language.add_item("Spanish")
	was_set()
	
func was_set():
	if SaveLoad.data["settings"].has("sfxvol"):
		sfx.value=float(SaveLoad.data["settings"]["sfxvol"])
	if SaveLoad.data["settings"].has("bgmvol"):
		music.value=float(SaveLoad.data["settings"]["bgmvol"])
	if SaveLoad.data["settings"].has("voice"):
		voice_select.selected=(SaveLoad.data["settings"]["voice"])
	if SaveLoad.data["settings"].has("lang"):
		language.selected=(SaveLoad.data["settings"]["lang"])

func _process(_delta):
	muslabel.text=str(music.value*100)+"%"
	sfxlabel.text=str(sfx.value*100)+"%"

func _on_Music_value_changed(value):
	SaveLoad.data["settings"]["bgmvol"]=value
	SaveLoad.save_game()
	pass

func _on_SFX_value_changed(value):
	SaveLoad.data["settings"]["sfxvol"]=value
	SaveLoad.save_game()
	pass

func _on_Language_item_selected(index):
	SaveLoad.data["settings"]["lang"]=index
	SaveLoad.save_game()
	pass

func _on_VoiceBloop_item_selected(index):
	SaveLoad.data["settings"]["voice"]=index
	SaveLoad.save_game()
	pass

func _on_Button_pressed():
	SceneChanger.change_scene("title",0)
	pass

func _on_Controls_pressed():
	SceneChanger.change_scene("controls",0)
	pass # Replace with function body.

func _on_Reset_Set_pressed():
	confirmdialog.popup()
	if confirmdialog:
		pass
	#SaveLoad.reset_data()
	#SaveLoad.save_game()
	was_set()
	pass # Replace with function body.
