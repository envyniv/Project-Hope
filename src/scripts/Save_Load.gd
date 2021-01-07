extends Node

var path="user://save.json"

var default_data = {
	"player":{
		"party":[],
		"inv":[], #inventory, duh
		"Kevin":{ #stats show base, not bonuses
			"HP":20, #health
			"DEF":10, #defense
			"EVA":8, #evasion
			"ATK":12, #attack
			"LV":1, #level
			"EXP":0, #experience
			"PRO":0, #proficiency/times the exp 0x up to 3x
			"CHR":0, #charm
			"LUC":0, #luck/chance of crit hit
			"god":[],
			"equip":[],
		},
		"Quinton":{
			"HP":17,
			"DEF":25,
			"EVA":6,
			"ATK":10,
			"LV":1,
			"EXP":0,
			"PRO":0,
			"CHR":0,
			"LUC":0,
			"equip":[],
		},
		"Charlie":{
			
		},
		"Bella":{
			
		},
	},
	"location": {
		"map":"Kevin's Bedroom",
		"boothid":null,
	},
	"settings": {
		"bgmvol":1,
		"sfxvol":1,
		"voice":0,
		"lang":0,
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
