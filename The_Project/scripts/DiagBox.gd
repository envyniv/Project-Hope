extends Node

onready var nametag=$Sprite/Label
onready var message=$Sprite/RichTextLabel
onready var anims=$AnimationPlayer
onready var next_spr=$Sprite/Sprite
var diagname = "test"
var file = File.new()
var diagpath = "scripts/dialogue/%s.json" % [diagname]
var dictionarynum = 1
var letter_spd = .1
signal start_dialogue
signal dialogue_end

func diag_start():
	#message.visible_characters=0
	anims.play("fade-in")
	
	if file.file_exists(diagpath):
		#print("file found. \npath: %s" % [diagpath])
		file.open(diagpath, file.READ)
		var json = file.get_as_text()
		var json_result = JSON.parse(json).result
		file.close()
		nametag.set_text(json_result[str(dictionarynum)]["name"])
		message.set_text(json_result[str(dictionarynum)]["msg"])
		#check if dialogue has 1 more line than the one you're being shown and show next button
		if dictionarynum<json_result.size():
			next_spr.show()
			#if the player presses attack and there's another line of dialogue, then, switch to that.
			pass
	else:
		nametag.set_text("System")
		message.set_text("ERROR: DIALOGUE %s MISSING; \nREPORT IMMEDIATELY" % [diagname])
pass

func diag_end():
	message.visible_characters=0
	anims.play_backwards("fade-in")
	message.set_text("null")
	nametag.set_text("null")
pass

func _ready():
	message.set_text("null")
	nametag.set_text("null")
	next_spr.hide()
	connect("start_dialogue", self, "diag_start");
pass
