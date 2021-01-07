extends Node

onready var nametag=$DiagBox/Label
onready var message=$DiagBox/RichTextLabel
onready var anims=$AnimationPlayer
onready var next_spr=$DiagBox/Next
onready var voicebox=$Voicebox
var file = File.new()
var index = 1
onready var timer=$next_char
var json_result
signal diag_started()
signal diag_ended()

func _ready():
	message.set_text("")
	nametag.set_text("")
	next_spr.hide()
pass

func diag_start(diagname):
	anims.play("fade-in")
	var diagpath = "res://scripts/dialogue/%s.json" % [diagname]
	if file.file_exists(diagpath):
		file.open(diagpath, file.READ)
		var json = file.get_as_text()
		json_result = JSON.parse(json).result
		print_text();
		read_text();
		emit_signal("diag_started")
		file.close()
	else:
		nametag.set_text("System")
		message.set_text("ERROR: DIALOGUE %s MISSING; \nISSUE IMMEDIATELY" % [diagname])
pass

func diag_end():
	message.visible_characters=0
	anims.play_backwards("fade-in")
	message.set_text("")
	nametag.set_text("")
	emit_signal("diag_ended")
pass

func read_text():
	voicialize()
	timer.wait_time = 0.1
	message.visible_characters = 0
	timer.start()
	pass

func voicialize():
	voicebox.remaining_sounds=[]
	if SaveLoad.data["settings"]["voice"]==0:
		voicebox.play_string(message.bbcode_text);
	elif SaveLoad.data["settings"]["voice"]==1:
		voicebox.bloop_string(message.bbcode_text);
	#check which character
	match nametag.text:
		"Kevin":
			voicebox.base_pitch=2
		"Quinton":
			voicebox.base_pitch=1.7
		"Charlie":
			voicebox.base_pitch=3.5
		"Bella":
			voicebox.base_pitch=2.3
		"F.dly Man":
			voicebox.base_pitch=2
		"F.dly Lady":
			voicebox.base_pitch=2.3
		"Rude Man":
			voicebox.base_pitch=1.7
		"Rude Lady":
			voicebox.base_pitch=2
		"Dolus":
			voicebox.base_pitch=1.9
		"Thanatos":
			voicebox.base_pitch=0.5
		"Envy":
			voicebox.base_pitch=1
	pass

func print_text():
	nametag.text = json_result[str(index)]["name"]
	message.bbcode_text = json_result[str(index)]["msg"]
	pass

func _input(_event):
	var NEXT=Input.is_action_just_pressed("ui_accept")
	if NEXT:
		if message.visible_characters!=message.bbcode_text.length()&&message.visible_characters!=-1:
			timer.stop()
			message.visible_characters=-1
			voicebox.remaining_sounds=[]
		elif index==json_result.size():
			diag_end()
		else:
			next()

func next():
	if index <= json_result.size():
		#for whatever reason the dialogue box can't get input
		index+=1
		print_text();
		read_text();
	pass

func _on_next_char_timeout():
	message.visible_characters += 1
	if message.visible_characters > message.bbcode_text.length():
		message.visible_characters -= 1
		timer.stop()
	pass
