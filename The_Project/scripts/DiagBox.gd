extends Node

onready var nametag=$Sprite/Label
onready var message=$Sprite/RichTextLabel
onready var anims=$AnimationPlayer
onready var next_spr=$Sprite/Sprite
onready var voicebox=$Voicebox
var diagname = "test"
var file = File.new()
var diagpath = "scripts/dialogue/%s.json" % [diagname]
var dictionarynum = 1
var timer: Timer
signal start_dialogue
signal dialogue_end
var json_result = null

#i think i blacked out when writing this.
func diag_start():
	anims.play("fade-in")
	
	if file.file_exists(diagpath):
		file.open(diagpath, file.READ)
		var json = file.get_as_text()
		json_result = JSON.parse(json).result
		file.close()
		nametag.text=json_result[str(dictionarynum)]["name"]
		message.text=json_result[str(dictionarynum)]["msg"]
		read_text();
		#check if dialogue has 1 more line than the one you're being shown and show next button
		if dictionarynum<json_result.size():
			next();
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
pass

func timer_tick():
	message.visible_characters += 1
	if message.visible_characters >= message.text.length():
		message.visible_characters = -1
		timer.stop()

func read_text():
	voicialize()
	timer = Timer.new()
	timer.wait_time = 0.08
	timer.autostart = true
	timer.connect("timeout", self, "timer_tick")
	message.visible_characters = 0
	add_child(timer)
	timer.start()
	pass

func voicialize():
	voicebox.play_string(message.text)
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
			voicebox.base_pitch=1.5
		"Envy":
			voicebox.base_pitch=1
	pass

func next():
	next_spr.show()
	if Input.is_action_pressed("ui_atklight"):
		dictionarynum+=1
		#print(dictionarynum)
	pass
