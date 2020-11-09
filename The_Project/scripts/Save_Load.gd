extends Node

var path="user://save.json"

var default_data = {
	"player":{
		"as":"Kevin",
		"HP":20, #health
		"DEF":5, #defense
		"EVA":8, #evasion
		"ATK":3, #attack
		"LV":0, #level
		"EXP":0, #experience
		"PRO":"0x", #proficiency/times the exp 0x up to 3x
		"CHR":"none", #charm
		"LUC":0, #luck/chance of crit hit
		"inv":[], #inventory, duh
	},
	"location": {
		"map":"Kevin's Bedroom",
		"boothid":null,
	},
	"settings": {
		"bgmvol":100,
		"sfxvol":100,
		"voice":0,
		"lang":"en",
		"controls":
			{
				"ui_left":"A",
				"ui_right":"D",
				"ui_up":"W",
				"ui_down":"S",
				"ui_sprint":"Shift",
				"ui_accept":"J",
				"ui_atkmed":"K",
				"ui_atkheavy":"N",
				"ui_atkgod":"M",
			},
	},
}

var data = {"settings":{}}

func load_game():
	var file=File.new();
	if not file.file_exists(path):
		reset_data()
		return
	file.open(path, file.READ)
	var text=file.get_as_text()
	data=parse_json(text)
	pass

func save_game():
	var file=File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	file.close()
	pass

func reset_data():
	data=default_data.duplicate(true)
	pass
	
func load_set():
	var file=File.new();
	if file.file_exists(path):
		file.open(path, file.READ)
		var text=file.get_as_text()
		data["settings"]=parse_json(text)["settings"]
	else:
		reset_data()
		return
	pass
