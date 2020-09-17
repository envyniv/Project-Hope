extends Node

onready var nametag=$Sprite/Label
onready var message=$Sprite/Label/Message
var diagname = null
var file = File.new()

file.open("res://scripts/dialogue/%d" % [diagname], file.READ)
var json = file.get_as_text()
var json_result = JSON.parse(json).result
file.close()

nametag.set_text(json_result["1"]["name"])
message.set_text(json_result["1"]["msg"])
