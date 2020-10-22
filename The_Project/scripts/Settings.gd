extends Node
onready var voice_select=$ColorRect/ScrollContainer/VBoxContainer/VoiceBloop

func _ready():
	var path="user://save.json"
	var file=File.new();
	voice_select.add_item("Alien")
	voice_select.add_item("Bloop")
	voice_select.add_item("None")
	voice_select.selected=0
	if not file.file_exists(path):
		SaveLoad.data["settings"]["voice"]=0
		SaveLoad.save_game()
	else:
		pass


func _on_Music_value_changed(value):
	SaveLoad.data["settings"]["bgmvol"]=str(value)
	SaveLoad.save_game()
	pass

func _on_SFX_value_changed(value):
	SaveLoad.data["settings"]["sfxvol"]=str(value)
	SaveLoad.save_game()
	pass

func _on_Languange_item_selected(index):
	SaveLoad.data["settings"]["lang"]=str(index)
	SaveLoad.save_game()
	pass

func _on_VoiceBloop_item_selected(index):
	SaveLoad.data["settings"]["voice"]=index
	SaveLoad.save_game()
	pass

func _on_Button_pressed():
	SceneChanger.change_scene("res://scenes/Title Screen.tscn",0)
	pass


func _on_Controls_pressed():
	SceneChanger.change_scene("res://scenes/Controls.tscn",0)
	pass # Replace with function body.
