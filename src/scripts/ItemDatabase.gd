extends Node

var items=[]

func _ready():
	var directory=Directory.new()
	directory.open("res://scripts/itemDB/")
	directory.list_dir_begin()
	var filename=directory.get_next()
	while(filename):
		if !directory.current_is_dir():
			items.append(load("res://scripts/itemDB/%s" % filename))
		filename=directory.get_next()

func get_item(item):
	for i in items:
		if i.name == item:
			return i
	return null
