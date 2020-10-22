extends Node
var existchk = File.new()
var file = CSVFile.new()
var itemDB = "res://scripts/itemDB.csv"
onready var sprite = $Sprite
var item_type=null

func _ready():
	var csv = file.load_file(itemDB)
	var datbas = file.get_map() #1 to 28 is gods
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
