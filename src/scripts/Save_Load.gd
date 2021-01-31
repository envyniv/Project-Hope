extends Node

var path="user://save.json"
var party=[] #max 3
var inv={} #max 200
var money=0 #max 999.999
var inBattle=false
var inDialog=true
var switch_stage={false:null}
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

var tempdata = {}

func _init():
	if !save_check("settings"):
		data["settings"]=default_data["settings"].duplicate(true)
	else:
		var file=File.new();
		file.open(path, file.READ)
		var text=file.get_as_text()
		data["settings"]=parse_json(text)["settings"]
		file.close()

func load_game():
	var file=File.new();
	file.open(path, file.READ)
	var text=file.get_as_text()
	data=parse_json(text)
	file.close()
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

# HACK: IF YOU WANT TO CHECK FOR SETTINGS, DO save_check("settings")
func save_check(check="player"):
	var file=File.new();
	file.open(path, file.READ)
	if file.file_exists(path):
		print("savefile at %s found." % path)
		var text=file.get_as_text()
		if parse_json(text).has(check):
			print("%s found in %s" % [check, path])
			return true
		else:
			print("%s NOT found in %s" % [check, path])
			return false
	else:
		print("%s not found." % path)
	file.close()

func add_item(item,qty=1):
	# if item is stackable append {item:qty}
	if ItemDatabase.get_item(item).Stackable:
		if item in inv:
			inv[item]+=qty
		else: 
			inv[item]=qty;
	else:
		inv[item]=0
	pass

func remove_item(item,qty=1):
	if ItemDatabase.get_item(item).Stackable:
		if item in inv:
			inv[item]-=qty
			if inv[item]<=1:
				inv.erase(item)
	else:
		if item in inv:
			inv.erase(item)
	pass

