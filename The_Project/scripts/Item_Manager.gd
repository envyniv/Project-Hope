extends Node
var existchk = File.new()
var file = CSVFile.new()
var itemDB = "res://scripts/itemDB.csv"
var item_type=null

var csv = file.load_file(itemDB)
var datbas = file.get_map()

func _ready():
	item_type="god"
	print(datbas.get("Apollo"))
	match item_type:
		"god":
			pass
		"medicine":
			pass
		"weapon":
			pass
		"clothes":
			pass
		"edible":
			pass

func item_getter(item):
	var res = datbas.get(item)
	return res
