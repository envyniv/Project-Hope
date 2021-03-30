extends Node

var path="user://save.json"

var party=[] #max 3
var inv=[] #inventory for non-stackable items; added because of necessity.
var invS={} #max 200

var money=100 #max 999.999
var level=1 #max 99
var inShop=false
var inBattle=false
var inDialog=false
var switch_stage={false:null}

var default_data = {
	"player":{
		"level":1,
		"money":100,
		"party":[],
		"inv":[], #inventory, duh
		"Kevin":{ #stats show base, not bonuses
			"LVL":1,
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
			"LVL":1,
			"HP":17,
			"DEF":25,
			"EVA":6,
			"ATK":8,
			"LV":1,
			"EXP":0,
			"PRO":0,
			"CHR":0,
			"LUC":0,
			"equip":[],
		},
		"Charlie":{
			"LVL":1,
			"HP":17,
			"DEF":25,
			"EVA":6,
			"ATK":8,
			"LV":1,
			"EXP":0,
			"PRO":0,
			"CHR":0,
			"LUC":0,
			"equip":[],
		},
		"Bella":{
			"LVL":1,
			"HP":17,
			"DEF":25,
			"EVA":6,
			"ATK":8,
			"LV":1,
			"EXP":0,
			"PRO":0,
			"CHR":0,
			"LUC":0,
			"equip":[],
		},
	},
	"location": {
		"map":"kevinsbedroom",
	},
	"settings": {
		"bgmvol":1,
		"sfxvol":1,
		"voice":0,
		"lang":"en",
		"controls":
			{
				"ui_left":"A",
				"ui_right":"D",
				"ui_up":"W",
				"ui_down":"S",
				"sprint":"Shift",
				"ui_accept":"J",
				"atkmed":"K",
				"ui_cancel":"N",
				"ui_select":"M",
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
	if inv.size() + invS.size()==32:
		return false
	if ItemDatabase.get_item(item).Stackable:
		if item in invS:
			if invS[item]==99:
				return false
			else:
				invS[item]+=qty
		else: 
			invS[item]=qty;
	else:
		inv.append(item)
	print(inv, invS)
	
	pass

func remove_item(item,qty=1):
	if ItemDatabase.get_item(item).Stackable:
		if item in invS:
			invS[item]-=qty
			if invS[item]<=0:
				invS.erase(item)
	else:
		if item in inv:
			inv.erase(item)
	pass

