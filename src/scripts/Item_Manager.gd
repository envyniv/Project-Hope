extends Node
var file = File.new()
var itemDB = "res://scripts/itemDB.db"

var csv = file.load_file(itemDB)
var datbas = file.get_map()

func _ready():
	pass
	
func item_getter(item):
	var res = datbas.get(item)
	return res
