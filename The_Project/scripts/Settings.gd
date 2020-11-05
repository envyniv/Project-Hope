extends Node
onready var voice_select=$ColorRect/ScrollContainer/VBoxContainer/VoiceBloop
onready var language=$ColorRect/ScrollContainer/VBoxContainer/Language

func _ready():
	var path="user://save.json"
	var file=File.new();
	voice_select.add_item("Alien")
	voice_select.add_item("Bloop")
	voice_select.add_item("None")

func _on_Music_value_changed(value):
	SaveLoad.data["settings"]["bgmvol"]=str(value)
	SaveLoad.save_game()
	pass

func _on_SFX_value_changed(value):
	SaveLoad.data["settings"]["sfxvol"]=str(value)
	SaveLoad.save_game()
	pass

func _on_Language_item_selected(index):
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


func _on_Reset_Set_pressed():
	SaveLoad.data["settings"]={}
	SaveLoad.save_game()
	pass # Replace with function body.
